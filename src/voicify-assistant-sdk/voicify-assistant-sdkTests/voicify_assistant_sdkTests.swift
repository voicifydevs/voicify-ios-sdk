//
//  voicify_assistant_sdkTests.swift
//  voicify-assistant-sdkTests
//
//  Created by Alex Dunn on 5/10/22.
//

import XCTest
@testable import voicify_assistant_sdk

class voicify_assistant_sdkTests: XCTestCase {
    public var voiceAssistant: VoicifyAssistant? = nil
    public var count: Array<Int> = [Int](repeating: 0, count: 2)
    override func setUpWithError() throws {
        super.setUp()
        voiceAssistant = VoicifyAssistant(speechToTextProvider: nil, textToSpeechProvider: nil, settings: VoicifyAssistantSettings(serverRootUrl: "https://assistant.voicify.com", appId: "99a803b7-5b37-426c-a02e-63c8215c71eb", appKey: "MTAzM2RjNDEtMzkyMC00NWNhLThhOTYtMjljMDc3NWM5NmE3", locale: "en-US", channel: "test", device: "test", autoRunConversation: true, initializeWithWelcomeMessage: false, initializeWithText: false, useVoiceInput: true, useDraftContent: false, useOutputSpeech: true, noTracking: false))
    }

    override func tearDownWithError() throws {
        voiceAssistant = nil
        super.tearDown()
    }

    func testHandlers() throws{
        let assistant = try XCTUnwrap(voiceAssistant)
        
        // RequestStartedHandlers
        assistant.onRequestStarted{request in
            self.count[0] = 1
        }
        //ResponseRecievedHandlers
        assistant.onResponseReceived{response in
            self.count[1] = 1
        }
        assistant.makeTextRequest(text: "hello", inputType: "text")
        //Assert Handlers Fired
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
