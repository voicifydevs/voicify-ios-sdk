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
    public var currentSessionInfo = VoicifySessionData(id: "", sessionFlags: [], sessionAttributes: [:])
    public var currentUserInfo = VoicifyUserData(id: "", userFlags: [], userAttributes: [:])
    
    public init (speechToTextProvider: VoicifySpeechToTextProvider?,
                 textToSpeechProvider: VoicifyTextToSpeechProvider?,
                 settings: VoicifyAssistantSettings){
        self.speechToTextProvider = speechToTextProvider
        self.textToSpeechProvider = textToSpeechProvider
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
        self.currentSessionInfo = VoicifySessionData(id: "", sessionFlags: [], sessionAttributes: [:])
        self.currentUserInfo = VoicifyUserData(id: "", userFlags: [], userAttributes: [:])
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
        textToSpeechProvider?.stop()
        requestStartedHandlers.forEach{requestStartedHandler in
            requestStartedHandler(request)
        }
        
        customAssistantRequest(request: request){(result: Result) in     // make the custom assistant request
            switch result {
            case .failure(let error):
                self.errorHandlers.forEach{errorHandler in
                    errorHandler(error.localizedDescription)
                }
            case .success(let assistantResponse):
                self.userDataRequest(inputType: inputType, assistantResponse: assistantResponse, request: request) // make the user data request
            }
        }
    }
        
    private func customAssistantRequest(request: CustomAssistantRequest, completion: @escaping (Result<CustomAssistantResponse, Error>) -> Void){
        do{
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
                            do {
                                if let customAssistantResponseDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                {
                                    let customAssistantResponse = self.convertDictionaryToResponseObject(response: customAssistantResponseDictionary)
                                    completion(.success(customAssistantResponse))
                                }
                                else{
                                    self.errorHandlers.forEach{errorHandler in
                                        errorHandler("empty response")
                                    }
                                }
                            }
                            catch let error {
                                self.errorHandlers.forEach{errorHandler in
                                    errorHandler(error.localizedDescription)
                                }
                            }
                    }
                }.resume()
        }
        catch{
            
        }
    }
    
    private func userDataRequest(inputType: String, assistantResponse: CustomAssistantResponse, request: CustomAssistantRequest){
        self.textToSpeechProvider?.clearHandlers()
        self.textToSpeechProvider?.addFinishListener {
            if(self.settings.autoRunConversation == true && self.settings.useVoiceInput == true && inputType == "Speech" && self.settings.useOutputSpeech && self.speechToTextProvider != nil && assistantResponse.endSession != true){
                self.speechToTextProvider?.startListening()
            }
        }
        if(self.textToSpeechProvider != nil && self.settings.useOutputSpeech)
        {
            if(!assistantResponse.ssml.isEmpty){
                self.textToSpeechProvider?.speakSsml(ssml: assistantResponse.ssml)
            }
            else if (!assistantResponse.outputSpeech.isEmpty)
            {
                self.textToSpeechProvider?.speakSsml(ssml: assistantResponse.outputSpeech)
            }
        }
        self.currentSessionInfo = VoicifySessionData(id: "", sessionFlags: assistantResponse.sessionFlags, sessionAttributes: assistantResponse.sessionAttributes)
        if let effectDictionary = assistantResponse.sessionAttributes["effects"] as? Array<[String: Any]>
        {
            let effects = self.decodeEffectsArray(effects: effectDictionary)
            effects.filter{effect in
                return effect.requestId == request.requestId
            }.forEach{effect in
                self.effectHandlers.filter{ effectHandler in
                    return effectHandler.effect == effect.effectName
                }.forEach{effectHandler in
                    effectHandler.callback(effect.data as Any)
                }
            }
        }
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
                    do{
                        let userDataResponseDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                        let userDataResponse = self.convertDictionaryToUserData(response: userDataResponseDictionary!)
                        self.currentUserInfo = userDataResponse
                        self.responseHandlers.forEach{responseHandler in
                            responseHandler(assistantResponse)
                        }
                        self.audioHandlers.forEach{audioHandler in
                            audioHandler(assistantResponse.audioFile)
                        }
                        self.videoHandlers.forEach{videoHandler in
                            videoHandler(assistantResponse.videoFile)
                        }
                        if(assistantResponse.endSession == true){
                            self.endSessionHandlers.forEach{endSessionHandler in
                                endSessionHandler(assistantResponse)
                            }
                        }
                        if(self.settings.autoRunConversation && self.settings.useVoiceInput && assistantResponse.endSession != true && inputType == "Speech" && (self.textToSpeechProvider == nil || !self.settings.useOutputSpeech)){
                            self.speechToTextProvider?.startListening()
                        }
                    }
                    catch let error {
                        self.errorHandlers.forEach{errorHandler in
                            errorHandler(error.localizedDescription)
                        }
                    }
            }
        }.resume()
        
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
                noTracking: settings.noTracking,
                requestType: "IntentRequest",
                requestName: "",
                slots: [:],
                originialInput: text,
                channel: self.settings.channel,
                requiresLanguageUnderstanding: true,
                locale: self.settings.locale,
                additionalRequestAttributes: requestAttributes ?? [:],
                additionalSessionAttributes: self.sessionAttributes ?? [:],
                additionalSessionFlags: []
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
                noTracking: settings.noTracking, requestType: "IntentRequest",
                requestName: "VoicifyWelcome",
                slots: [:],
                originialInput: "[Automated]",
                channel: self.settings.channel,
                requiresLanguageUnderstanding: false,
                locale: self.settings.locale,
                additionalRequestAttributes: requestAttributes ?? [:],
                additionalSessionAttributes: self.sessionAttributes ?? [:],
                additionalSessionFlags: []
            ),
            device: generateDevice(),
            user: generateUser()
        )
    }
    public func generateUser() -> CustomAssistantUser{
        return CustomAssistantUser(
            id: self.userId ?? "",
            name: self.userId ?? "",
            accessToken: self.accessToken ?? "",
            additionalSessionAttributes: self.userAttributes ?? [:],
            additionalSessionFlags: []
        )
    }
    
    public func generateDevice() -> CustomAssistantDevice{
        return CustomAssistantDevice(
            id: self.settings.device,
            name: self.settings.device,
            supportsVideo: true,
            supportsForegroundImage: true,
            supportsBackgroundImage: true,
            supportsAudio: true,
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
    
    func decodeEffectsArray(effects: Array<Dictionary<String, Any>>) -> Array<VoicifySessionEffect>{
        var sessionEffects: Array<VoicifySessionEffect> = []
        effects.forEach{effect in
            let sessionEffect = VoicifySessionEffect(effectName: "", requestId: "", data: {})
            if let name = effect["effectName"] as? String{
                sessionEffect.effectName = name
            }
            if let id = effect["requestId"] as? String{
                sessionEffect.requestId = id
            }
            if let data = effect["data"]{
                sessionEffect.data = data
            }
            sessionEffects.append(sessionEffect)
        }
        return sessionEffects
    }
    
    func convertDictionaryToUserData(response: Dictionary<String, Any>) -> VoicifyUserData{
        let userData = VoicifyUserData(id: "", userFlags: [], userAttributes: [:])
        if let id = response["id"] as? String {
            userData.id = id
        }
        if let userFlags = response["userFlags"] as? [String]{
            userData.userFlags = userFlags
        }
        if let userAttributes = response["userAttributes"] as? [String : Any]{
            userData.userAttributes = userAttributes
        }
        return userData
    }
    
    func convertDictionaryToSessionData(response: Dictionary<String, Any>) -> VoicifySessionData{
        let sessionData = VoicifySessionData(id: "", sessionFlags: [], sessionAttributes: [:])
        if let id = response["id"] as? String{
            sessionData.id = id
        }
        if let sessionFlags = response["sessionFlags"] as? Array<String>{
            sessionData.sessionFlags = sessionFlags
        }
        if let sessionAttributes = response["sessionAttributes"] as? Dictionary<String, Any>{
            sessionData.sessionAttributes = sessionAttributes
        }
        return sessionData
    }
    
    func convertDictionaryToResponseObject(response: Dictionary<String, Any>) -> CustomAssistantResponse{
        let decodedResponse = CustomAssistantResponse(responseId: "", ssml: "", outputSpeech: "", displayText: "", responseTemplate: "", foregroundImage: "", backgroundImage: "", audioFile: MediaItemModel(id: "", url: "", name: ""), videoFile: MediaItemModel(id: "", url: "", name: ""), sessionAttributes: [:], sessionFlags: [], hints: [], listItems: [], endSession: false)
        if let responseId = response["responseId"] as? String{
            decodedResponse.responseId = responseId
        }
        if let ssml = response["ssml"] as? String {
            decodedResponse.ssml = ssml
        }
        if let outputSpeech = response["outputSpeech"] as? String {
            decodedResponse.outputSpeech = outputSpeech
        }
        if let displayText = response["displayText"] as? String {
            decodedResponse.displayText = displayText
        }
        if let responseTemplate = response["responseTemplate"] as? String{
            decodedResponse.responseTemplate = responseTemplate
        }
        if let foregroundImage = response["foregroundImage"] as? String{
            decodedResponse .foregroundImage = foregroundImage
        }
        if let backgroundImage = response["backgroundImage"] as? String{
            decodedResponse.backgroundImage = backgroundImage
        }
        if let audioFile = response["audioFile"] as? [String: Any]
        {
            if let audioFileId = audioFile["id"] as? String{
                decodedResponse.audioFile.id = audioFileId
            }
            
            if let audioUrl = audioFile["url"] as? String{
                decodedResponse.audioFile.url = audioUrl
            }
            
            if let audioName = audioFile["name"] as? String{
                decodedResponse.audioFile.name = audioName
            }
        }
        if let videoFile = response["videoFile"] as? [String: Any]
        {
            if let videoFileId = videoFile["id"] as? String{
                decodedResponse.videoFile.id = videoFileId
            }
            
            if let videoUrl = videoFile["url"] as? String{
                decodedResponse.videoFile.url = videoUrl
            }
            
            if let videoName = videoFile["name"] as? String{
                decodedResponse.videoFile.name = videoName
            }
        }
        if let sessionAttributes = response["sessionAttributes"] as? [String: Any] {
            decodedResponse.sessionAttributes = sessionAttributes
        }
        if let sessionFlags = response["sessionFlags"] as? [String]{
            decodedResponse.sessionFlags = sessionFlags
        }
        if let hints = response["hints"] as? [String]{
            decodedResponse.hints = hints
        }
        if let assistantListItems = response["listItems"] as? Array<[String: Any]>{
            var listItems: Array<CustomAssistantListItem> = []
            assistantListItems.forEach{assistantListItem in
                let listItem = CustomAssistantListItem(id: "", title: "", description: "", image: "")
                if let listItemId = assistantListItem["id"] as? String {
                    listItem.id = listItemId
                }
                if let listItemTitle = assistantListItem["title"] as? String {
                    listItem.title = listItemTitle
                }
                if let listItemDescription = assistantListItem["description"] as? String {
                    listItem.description = listItemDescription
                }
                if let listItemImage = assistantListItem["image"] as? String {
                    listItem.image = listItemImage
                }
                listItems.append(listItem)
            }
            decodedResponse.listItems = listItems
        }
        if let endSession = response["endSession"] as? Bool{
            decodedResponse.endSession = endSession
        }
        return decodedResponse
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
