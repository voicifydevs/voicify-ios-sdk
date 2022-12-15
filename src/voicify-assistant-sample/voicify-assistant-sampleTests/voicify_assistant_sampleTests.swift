//
//  voicify_assistant_sampleTests.swift
//  voicify-assistant-sampleTests
//
//  Created by Alex Dunn on 5/10/22.
//

import XCTest
import voicify_assistant_sdk
@testable import voicify_assistant_sample

class voicify_assistant_tests: XCTestCase {
    public var voiceAssistant: VoicifyAssistant? = nil
    override func setUpWithError() throws {
        super.setUp()
        voiceAssistant = VoicifyAssistant(speechToTextProvider: nil, textToSpeechProvider: nil, settings: VoicifyAssistantSettings(serverRootUrl: "https://assistant.voicify.com", appId: "665730ca-6687-442c-863d-7db30f22c0e6", appKey: "MGRmOTU4MzQtYzhkMi00Y2UxLTg1MTQtODMzNWIyNGU1YmFj", locale: "en-US", channel: "channel", device: "device", autoRunConversation: true, initializeWithWelcomeMessage: false, initializeWithText: false, useVoiceInput: true, useDraftContent: false, useOutputSpeech: true, noTracking: false))
        voiceAssistant?.startNewSession()
    }

    override func tearDownWithError() throws {
        voiceAssistant = nil
        super.tearDown()
    }
    
    func testHandlers() throws{
        //variable declaration
        let assistant = try XCTUnwrap(voiceAssistant)
        let requestExpectation = self.expectation(description: "the request handler")
        let responseExpectation = self.expectation(description: "the response handler")
        let endSessionResponseExpectation = self.expectation(description: "the end session handler")
        let effectExpectation = self.expectation(description: "the effect handler")
        let audioExpectation = self.expectation(description: "the audio handler")
        let videoExpectation = self.expectation(description: "the video handler")
        var tempRequest: CustomAssistantRequest? = nil
        var tempResponse: CustomAssistantResponse? = nil
        var tempEndSessionResponse: CustomAssistantResponse? = nil
        var tempAudioResponse: MediaItemModel? = nil
        var tempVideoResponse: MediaItemModel? = nil
        var playEffectFired = false
        
        // RequestStartedHandlers
        assistant.onRequestStarted{request in
            tempRequest = request
            requestExpectation.fulfill()
        }
        //ResponseRecievedHandlers
        assistant.onResponseReceived{response in
            tempResponse = response
            responseExpectation.fulfill()
        }
        //EndSessionHandlers
        assistant.onSessionEnded{response in
            tempEndSessionResponse = response
            endSessionResponseExpectation.fulfill()
        }
        //EffectHandlers
        assistant.onEffect(effectName: "play"){data in
            playEffectFired = true
            effectExpectation.fulfill()
        }
        //AudioHandlers
        assistant.onPlayAudio{mediaItem in
            tempAudioResponse = mediaItem
            audioExpectation.fulfill()
        }
        //VideoHandlers
        assistant.onPlayVideo{videoItem in
            tempVideoResponse = videoItem
            videoExpectation.fulfill()
        }
        
        assistant.makeTextRequest(text: "Test Response", inputType: "text")
       
        // wait for handlers to fire
        let result = XCTWaiter.wait(for: [requestExpectation, responseExpectation, endSessionResponseExpectation, effectExpectation, audioExpectation, videoExpectation], timeout: 5.0)
       
        //Assert Handlers Fired
        switch result {
            case .completed:
            //Assert Request Started Handlers
            if let theRequest = tempRequest{
                XCTAssert(theRequest.device.name == "device")
                XCTAssert(theRequest.context.channel == "channel")
                XCTAssert(theRequest.context.locale == "en-US")
            }
            else
            {
                XCTFail("request is null")
            }
            //Assert Response Received Handlers
            if let theResponse = tempResponse{
                XCTAssert(theResponse.outputSpeech == "here is the response")
                XCTAssert(theResponse.effects[0].name == "play")
                XCTAssert(theResponse.endSession == true)
            }
            else
            {
                XCTFail("response is null")
            }
            //Assert End Session Handlers
            if let theEndSessionResponse = tempEndSessionResponse {
                XCTAssert(theEndSessionResponse.displayText.trimmingCharacters(in: .whitespacesAndNewlines) == "here is the response")
            }
            else{
                XCTFail("end session response is null")
            }
            //Assert Effect Handlers
            XCTAssert(playEffectFired == true)
            //Assert Audio Handlers
            if let theAudioResponse = tempAudioResponse {
                XCTAssert(theAudioResponse.url == "https://voicify-prod-files.s3.amazonaws.com/665730ca-6687-442c-863d-7db30f22c0e6/ba125dbd-b0d5-4d99-a3c1-40560f9b1b85/173-Portland-St.mp3")
            }
            else {
                XCTFail("audio response is null")
            }
            //Assert Video Handlers
            if let theVideoResponse = tempVideoResponse {
                XCTAssert(theVideoResponse.url == "https://voicify-prod-files.s3.amazonaws.com/665730ca-6687-442c-863d-7db30f22c0e6/ef85725b-a01b-4a45-86da-2ac652a6409f/Screen-Recording-20221114-123949-P-QARC.mp4")
            }
            else {
                XCTFail("video response is null")
            }
            case .incorrectOrder:  XCTFail("incorrect order")
            case .timedOut:  XCTFail("handlers timed out")
            default: print("There was an issue")
        }
        
        
        
    }
    
    func testResponseSessionAttributes () throws {
        //assistant.makeTextRequest(text: "Test Response", inputType: "text")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
