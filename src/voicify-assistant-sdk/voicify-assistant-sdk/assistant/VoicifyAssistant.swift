//
//  VoicifyAssistant.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 10/31/22.
//

import Foundation
import SwiftUI

public class VoicifyAssistant : ObservableObject
{
    private var speechToTextProvider: VoicifySpeechToTextProvider? = nil
    private var textToSpeechProvider: VoicifyTextToSpeechProvider? = nil
    private var settings: VoicifyAssistantSettings
    private var sessionId: String? = nil
    private var userId: String? = nil
    private var accessToken: String? = nil
    private var sessionAttributes: Dictionary<String, Any>? = nil
    private var userAttributes: Dictionary<String, Any>? = nil
    private var errorHandlers: Array<(String) -> Void> = []
    private var effectHandlers: Array<EffectModel> = []
    private var requestStartedHandlers: Array<(CustomAssistantRequest) -> Void> = []
    private var responseHandlers: Array<(CustomAssistantResponse) -> Void> = []
    private var endSessionHandlers: Array<(CustomAssistantResponse) -> Void> = []
    private var audioHandlers: Array<(MediaItemModel? ) -> Void> = []
    private var videoHandlers: Array<(MediaItemModel? ) -> Void> = []
    private var currentSessionInfo: VoicifySessionData? = nil
    private var currentUserInfo: VoicifyUserData? = nil
    
    public init (speechToTextProvider: VoicifySpeechToTextProvider,
                 textToSpeechProivder: VoicifyTextToSpeechProvider,
                 settings: VoicifyAssistantSettings){
        self.speechToTextProvider = speechToTextProvider
        self.textToSpeechProvider = textToSpeechProivder
        self.settings = settings
    }
    
    public func initializeAndStart(){
        self.textToSpeechProvider?.initialize(locale: settings.locale)
        self.speechToTextProvider?.initialize(locale: settings.locale)
    }
    
    public func startNewSession(sessionId: String? = nil, userId: String? = nil, sessionAttributes: Dictionary<String, Any>? = nil, userAttributes: Dictionary<String, Any>? = nil){
        self.sessionId = self.sessionId ?? UUID().uuidString
        self.userId = self.userId ?? UUID().uuidString
        self.sessionAttributes = sessionAttributes
        self.userAttributes = userAttributes
        self.currentSessionInfo = nil
        self.currentUserInfo = nil
        if(settings.initializeWithWelcomeMessage)
        {
            makeWelcomeMessage(requestAttributes: nil)
        }
    }
    
    public func onEffect(effectName: String, callback: @escaping (Any) -> Void){
        self.effectHandlers.append(EffectModel(effect: effectName, callback: callback))
    }
    
    public func onError(callback: @escaping (String) -> Void){
        self.errorHandlers.append(callback)
    }
    
    public func onRequestStarted(callback: @escaping (CustomAssistantRequest) -> Void){
        self.requestStartedHandlers.append(callback)
    }
    
    public func onResponseReceived(callback: @escaping (CustomAssistantResponse) -> Void){
        self.responseHandlers.append(callback)
    }
    
    public func onSessionEnded(callback: @escaping (CustomAssistantResponse) -> Void){
        self.endSessionHandlers.append(callback)
    }
    
    public func onPlayVideo(callback: @escaping (MediaItemModel?) -> Void){
        self.videoHandlers.append(callback)
    }
    
    public func onPlayAudio(callback: @escaping (MediaItemModel?) -> Void){
        self.audioHandlers.append(callback)
    }
    
    public func ClearHandlers() {
        self.audioHandlers = []
        self.videoHandlers = []
        self.endSessionHandlers = []
        self.responseHandlers = []
        self.requestStartedHandlers = []
        self.effectHandlers = []
        self.errorHandlers = []
    }
    
    public func makeRequest(request: CustomAssistantRequest, inputType: String){
        do{
            textToSpeechProvider?.stop()
            requestStartedHandlers.forEach{requestStartedHandler in
                requestStartedHandler(request)
            }
            let useDraftContent = settings.useDraftContent ? "&useDraftContent=true" : ""
            guard let customRequestUrl = URL(string: "\(settings.serverRootUrl)/api/customAssistant/handlerequest?applicationId=\(settings.appId)&applicationSecret=\(settings.appKey)\(useDraftContent)") else { fatalError("Missing URL") }
            let encodedCustomRequestBody = try JSONSerialization.data(withJSONObject: convertRequestToDictionary(request: request), options: [])
            let customAssistantRequest = generatePostRequest(requestBody: encodedCustomRequestBody, url: customRequestUrl)
            URLSession.shared.dataTask(with: customAssistantRequest) { (data, response, error) in
                if let error = error {
                    self.errorHandlers.forEach{errorHandler in
                        errorHandler(error.localizedDescription)
                    }
                    return
                }
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async { [self] in
                        do {
                            let customAssistantResponseDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                            let customAssistantResponse = convertDictionaryToResponseObject(response: customAssistantResponseDictionary!)
                            self.textToSpeechProvider?.clearHandlers()
                            self.textToSpeechProvider?.addFinishListener {
                                if(self.settings.autoRunConversation && self.settings.useVoiceInput && inputType == "Speech" && self.settings.useOutputSpeech && self.speechToTextProvider != nil && customAssistantResponse.endSession != false){
                                    self.speechToTextProvider?.startListening()
                                }
                            }
                            if(self.textToSpeechProvider != nil && self.settings.useOutputSpeech)
                            {
                                if(customAssistantResponse.ssml != nil)
                                {
                                    self.textToSpeechProvider?.speakSsml(ssml: customAssistantResponse.ssml!)
                                }
                                else if (customAssistantResponse.outputSpeech != nil){
                                    self.textToSpeechProvider?.speakSsml(ssml: customAssistantResponse.outputSpeech!)
                                }
                            }
                            guard let sessionDataRequestUrl = URL(string: "\(self.settings.serverRootUrl)/api/UserProfile/session/\( self.sessionId!)?applicationId=\(self.settings.appId)&applicationSecret=\(self.settings.appKey)") else { fatalError("Missing URL") }
                            let sessionDataRequest = self.generateGetRequest(url: sessionDataRequestUrl)
                            URLSession.shared.dataTask(with: sessionDataRequest) { (data, response, error) in
                                if let error = error {
                                    self.errorHandlers.forEach{errorHandler in
                                        errorHandler(error.localizedDescription)
                                    }
                                    return
                                }
                                guard let response = response as? HTTPURLResponse else { return }
                                if response.statusCode == 200 {
                                    guard let data = data else { return }
                                    DispatchQueue.main.async {
                                        do {
                                            let sessionDataResponseDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                            let sessionDataResponse = converDictionaryToSessionData(response: sessionDataResponseDictionary!)
                                            print(sessionDataResponse)
                                            let effects = sessionDataResponse?.sessionAttributes["effects"] as? Array<VoicifySessionEffect>
                                            self.currentSessionInfo = sessionDataResponse
                                            effects?.filter{effect in
                                                return effect.requestId == request.requestId
                                            }.forEach{effect in
                                                self.effectHandlers.filter{ effectHandler in
                                                    return effectHandler.effect == effect.effectName
                                                }.forEach{effectHandler in
                                                    effectHandler.callback(effect.data)
                                                }
                                            }
                                        }
                                        catch let error {
                                            self.errorHandlers.forEach{errorHandler in
                                                errorHandler(error.localizedDescription)
                                            }
                                        }
                                    }
                                }
                            }.resume()
                            guard let userDataRequestUrl = URL(string: "\(self.settings.serverRootUrl)/api/UserProfile/\( self.userId!)?applicationId=\(self.settings.appId)&applicationSecret=\(self.settings.appKey)") else { fatalError("Missing URL") }
                            let userDataRequest = self.generateGetRequest(url: userDataRequestUrl)
                            URLSession.shared.dataTask(with: userDataRequest) { (data, response, error) in
                                if let error = error {
                                    self.errorHandlers.forEach{errorHandler in
                                        errorHandler(error.localizedDescription)
                                    }
                                    return
                                }
                                guard let response = response as? HTTPURLResponse else { return }
                                if response.statusCode == 200 {
                                    guard let data = data else { return }
                                    DispatchQueue.main.async {
                                        do{
                                            let userDataResponse = try JSONSerialization.jsonObject(with: data) as? VoicifyUserData
                                            self.currentUserInfo = userDataResponse
                                        }
                                        catch let error {
                                            self.errorHandlers.forEach{errorHandler in
                                                errorHandler(error.localizedDescription)
                                            }
                                        }
                                    }
                                }
                            }.resume()
                            self.responseHandlers.forEach{responseHandler in
                                responseHandler(customAssistantResponse)
                            }
                            if(customAssistantResponse.audioFile != nil){
                                self.audioHandlers.forEach{audioHandler in
                                    audioHandler(customAssistantResponse.audioFile)
                                }
                            }
                            if(customAssistantResponse.videoFile != nil){
                                self.videoHandlers.forEach{videoHandler in
                                    videoHandler(customAssistantResponse.videoFile)
                                }
                            }
                            if(customAssistantResponse.endSession == true){
                                self.endSessionHandlers.forEach{endSessionHandler in
                                    endSessionHandler(customAssistantResponse)
                                }
                            }
                            if(self.settings.autoRunConversation && self.settings.useVoiceInput && customAssistantResponse.endSession != true && inputType == "Speech" && (self.textToSpeechProvider != nil || !self.settings.useOutputSpeech)){
                                self.speechToTextProvider?.startListening()
                            }
                        } catch let error {
                            self.errorHandlers.forEach{errorHandler in
                                errorHandler(error.localizedDescription)
                            }
                        }
                    }
                }
            }.resume()
        }
        catch let requestError{
            self.errorHandlers.forEach{errorHandler in
                errorHandler(requestError.localizedDescription)
            }
        }
    }
    
    public func makeTextRequest(text: String, requestAttributes: Dictionary<String, Any>? = nil, inputType: String){
        let request = generateTextRequest(text: text)
        makeRequest(request: request, inputType: inputType)
    }
    
    public func generateTextRequest(text: String, requestAttributes: Dictionary<String, Any>? = nil) -> CustomAssistantRequest {
        return CustomAssistantRequest(
            requestId: UUID().uuidString,
            context: CustomAssistantRequestContext(
                sessionId: self.sessionId ?? "",
                requestType: "IntentRequest",
                originialInput: text,
                channel: self.settings.channel,
                requiresLanguageUnderstanding: true,
                locale: self.settings.locale,
                additionalRequestAttributes: requestAttributes ?? [:],
                additionalSessionAttributes: self.sessionAttributes ?? [:]
            ),
            device: generateDevice(),
            user: generateUser()
        )
    }
    
    public func makeWelcomeMessage(requestAttributes: Dictionary<String, Any>? = nil){
        let request = generateWelcomeRequest(requestAttributes: requestAttributes)
        if(settings.autoRunConversation)
        {
            makeRequest(request: request, inputType: "Speech")
        }
        else{
            makeRequest(request: request,inputType: "Text")
        }
    }
    
    public func generateWelcomeRequest (requestAttributes: Dictionary<String, Any>? = nil) -> CustomAssistantRequest{
        return CustomAssistantRequest(
            requestId: UUID().uuidString,
            context: CustomAssistantRequestContext(
                sessionId: self.sessionId ?? "",
                requestType: "IntentRequest",
                requestName: "VoicifyWelcome",
                originialInput: "[Automated]",
                channel: self.settings.channel,
                requiresLanguageUnderstanding: false,
                locale: self.settings.locale,
                additionalRequestAttributes: requestAttributes ?? [:],
                additionalSessionAttributes: self.sessionAttributes ?? [:]
            ),
            device: generateDevice(),
            user: generateUser()
        )
    }
    public func generateUser() -> CustomAssistantUser{
        return CustomAssistantUser(
            id: self.userId ?? "",
            name: self.userId,
            accessToken: self.accessToken,
            additionalSessionAttributes:
            self.userAttributes
        )
    }
    
    public func generateDevice() -> CustomAssistantDevice{
        return CustomAssistantDevice(
            id: self.settings.device,
            name: self.settings.device,
            supportsSsml: true,
            supportsDisplayText: true,
            supportsVoiceInput: true,
            supportsTextInput: true
        )
    }
    
    public func addSessionAttribute(key: String, value: Any){
        self.sessionAttributes?[key] = value
    }
    
    public func addUserAttributes(key: String, value: Any){
        self.userAttributes?[key] = value
    }
    
    public func addAccessToken(token: String){
        self.accessToken = token
    }
    
    func generateGetRequest(url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func generatePostRequest(requestBody: Data, url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBody
        return request
    }
    
    func converDictionaryToSessionData(response: Dictionary<String, Any>) -> VoicifySessionData{
        return VoicifySessionData(
            id: String(describing: response["id"]),
            sessionFlags: response["sessionFlags"] as? Array<String>,
            sessionAttributes: response["sessionAttributes"] as? Dictionary<String, Any>
        )
    }
    
    func convertDictionaryToResponseObject(response: Dictionary<String, Any>) -> CustomAssistantResponse{
        let audioFile =  response["audioFile"] as? [String: Any]
        let videoFile =  response["videoFile"] as? [String: Any]
        return CustomAssistantResponse(
            responseId: String(describing: response["responseId"]),
            ssml: String(describing: response["ssml"]),
            outputSpeech: String(describing: response["outputSpeech"]),
            displayText: String(describing: response["displayText"]),
            responseTemplate: String(describing: response["responseTemplate"]),
            foregroundImage: String(describing: response["foregroundImage"]),
            backgroundImage: String(describing: response["backgroundImage"]),
            audioFile: MediaItemModel(
                id: String(describing: audioFile?["id"]),
                url: String(describing: audioFile?["url"]),
                name: String(describing: audioFile?["name"])
            ),
            videoFile: MediaItemModel(
                id: String(describing: videoFile?["id"]),
                url: String(describing: videoFile?["url"]),
                name: String(describing: videoFile?["name"])
            ),
            sessionAttributes: response["sessionAttributes"] as? Dictionary<String, Any>,
            hints: response["hints"] as? Array<String>,
            listItems: response["listItems"] as? Array<CustomAssistantListItem>,
            endSession: response["endSession"] as? Bool)
    }
    
    func convertRequestToDictionary(request: CustomAssistantRequest) -> Dictionary<String, Any>{
        let json: Dictionary<String, Any> = [
              "requestId": "\(request.requestId)",
              "user": [
                "id": "\(request.user.id)",
                "name": "\(request.user.name)",
                "accessToken": "\(request.user.accessToken)"
              ],
              "device": [
                "id": "\(request.user.id)",
                "name": "\(request.user.id)",
                "supportsAudio": "\(request.device.supportsAudio)",
                "supportsBackgroundImage": "\(request.device.supportsBackgroundImage)",
                "supportsDisplayText": "\(request.device.supportsDisplayText)",
                "supportsForegroundImage": "\(request.device.supportsForegroundImage)",
                "supportsSsml": "\(request.device.supportsSsml)",
                "supportsTextInput": "\(request.device.supportsTextInput)",
                "supportsVideo": "\(request.device.supportsVideo)",
                "supportsVoiceInput": "\(request.device.supportsVoiceInput)"
              ],
              "context": [
                "sessionId": "\(request.context.sessionId)",
                "requestName": "\(request.context.requestName)",
                "requestType": "\(request.context.requestType)",
                "requiresLanguageUnderstanding": "\(request.context.requiresLanguageUnderstanding)",
                "originalInput": "\(request.context.originialInput)",
                "noTracking": "\(request.context.noTracking)",
                "locale": "\(request.context.locale)",
                "channel": "\(request.context.channel)"
              ]
            ]
        return json
    }
}
