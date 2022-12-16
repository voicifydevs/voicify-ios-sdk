//
//  voicify_assistant_sampleUITests.swift
//  voicify-assistant-sampleUITests
//
//  Created by Alex Dunn on 5/10/22.
//

import XCTest

class voicify_assistant_sampleUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPlayEffect() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let timeout = 15.0
        
        let openAssistantButton = app.buttons["openAssistantButton"]
        XCTAssertTrue(openAssistantButton.waitForExistence(timeout: timeout))
        openAssistantButton.tap()
        
        let messageInputField = app.textFields["messageInputField"]
        XCTAssertTrue(messageInputField.waitForExistence(timeout: timeout))
        messageInputField.tap()
        messageInputField.typeText("play how we got here")
        
        let sendButton = app.buttons["sendButton"]
        XCTAssertTrue(messageInputField.waitForExistence(timeout: timeout))
        sendButton.tap()
        
        let messageSentText = app.staticTexts["messageSentText"]
        XCTAssertTrue(messageSentText.waitForExistence(timeout: timeout))
        
        XCTAssert(messageSentText.label == "play how we got here")
        
        let messageReceivedText = app.staticTexts["messageReceivedText"]
        XCTAssertTrue(messageReceivedText.waitForExistence(timeout: timeout))
        let receivedLabel = messageReceivedText.label.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print(receivedLabel)
        XCTAssert(String(receivedLabel) == "Here's how we got here by explosive ear candy")
        
        let songTitleText = app.staticTexts["songTitleText"]
        XCTAssertTrue(songTitleText.waitForExistence(timeout: timeout))
        
        XCTAssert(songTitleText.label == "Now Playing How We Got Here")
        
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
