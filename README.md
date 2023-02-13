# Introduction
This project includes the models, API methods and classes for interacting with the Voicify Custom Assistant API in Swift, as well as a customizable Voicify Assistant component for native ios.

# Getting Started
You may need to add some permissions to your IOS Target Properties:

Key: Privacy - Speech Recognition Usage Description
Value: Your Usage Description Goes Here

Key: Privacy - Microphone Usage Description
Value: Your Usage Description Goes Here

This SDK offers several out-of-the-box solutions, including:
- A customizable Voicify Custom Assistant component
- A speech to text (STT) class 
- A text to speech (TTS) class

This SDK also offers a variety of tools for creating your own Voice Assistant, including:
- A Voicify Assistant class for making requests to your Voicify Custom Assistant
- A speech to text class (STT) for providing your own STT
- A text to speech class (TTS) for providing your own TTS 

Whether you are looking for a quick and easy way to add a Voicify Assistant to your project, or you are building your own assistant from scratch, this SDK has all the details you need as long as you have a Voicify app to make requests against and the `severRootUrl`, `applicationId` and `applicationSecret` required to make requests. Voicify users can find these resources in the deployments page of the application that they are using with the SDK.
​
## Using the Assistant Drawer UI
The Assistant Drawer UI component is prebuilt to allow for an easy solution for implementing a Voicify Assistant in your project. The component requires some settings that get passed in as props and then its ready to go. All of the props that are not part of the styling, (the header, body and toolbar objects), are required. Contrastly, none of the styling props are required.

For example, the component can be initialized with the required settings and a no styling options.

The drawer can be opened by posting to the Notification Center:
```swift
NotificationCenter.default.post(Notification(name: NSNotification.Name.openAssistant))
```
Similarly, the drawer can be closed by using: 
```swift
NotificationCenter.default.post(Notification(name: NSNotification.Name.closeAssistant))
```

A full list of the Assistant Drawer UI Properties includes:
**Required**

**_assistant settings_**
- serverRootUrl
- appId
- appKey


**Optional**
- configurationId
- textToSpeechProvider
- locale
- textToSpeechVoice
- channel
- device
- initializeWithText
- autoRunConversation
- initializeWithWelcomeMessage
- useOutputSpeech
- useVoiceInput
- noTracking
- useDraftContent
- backgroundColor
- effects

**Optional (styles)**

**_header_**

- assistantImage
- assistantImageBackgroundColor
- assistantImageBorderWidth
- assistantImageBorderColor
- assistantImageBorderStyle
- assistantImageBorderRadius
- assistantImagePadding
- assistantImageWidth
- assistantImageHeight
- assistantName
- assistantNameTextColor
- backgroundColor
- closeAssistantButtonBackgroundColor
- closeAssistantButtonBorderColor
- closeAssistantButtonBorderRadius
- closeAssistantButtonBorderStyle
- closeAssistantButtonBorderWidth
- closeAssistantButtonImage
- closeAssistantColor
- fontFamily
- fontSize
- minimizeAssistantColor
- minimizeButtonBorderRadius
- minimizeButtonHeight
- minimizeButtonWidth
- minimizeIcon
- paddingBottom
- paddingLeft
- paddingRight
- paddingTop

**_body_**

- assistantImage
- assistantImageBorderColor
- assistantImageBorderRadius
- assistantImageBorderStyle
- assistantImageBorderWidth
- assistantImagePadding
- backgroundColor
- borderBottomColor
- borderTopColor
- height
- hintsBackgroundColor
- hintsBorderColor
- hintsBorderRadius
- hintsBorderStyle
- hintsBorderWidth
- hintsFontFamily
- hintsFontSize
- hintsPaddingBottom
- hintsPaddingLeft
- hintsPaddingRight
- hintsPaddingTop
- hintsTextColor
- messageReceivedBackgroundColor
- messageReceivedBorderBottomLeftRadius
- messageReceivedBorderBottomRightRadius
- messageReceivedBorderColor
- messageReceivedBorderRadius
- messageReceivedBorderStyle
- messageReceivedBorderTopLeftRadius
- messageReceivedBorderTopRightRadius
- messageReceivedBorderWidth
- messageReceivedFontFamily
- messageReceivedFontSize
- messageReceivedTextColor
- messageSentBackgroundColor
- messageSentBorderBottomLeftRadius
- messageSentBorderBottomRightRadius
- messageSentBorderColor
- messageSentBorderRadius
- messageSentBorderStyle
- messageSentBorderTopLeftRadius
- messageSentBorderTopRightRadius
- messageSentBorderWidth
- messageSentFontFamily
- messageSentFontSize
- messageSentTextColor
- padding
- paddingBottom
- paddingLeft
- paddingRight
- paddingTop
- videoWidth
- videoHeight

**_toolbar_**

- activeMicImagePadding
- assistantStateFontColor
- assistantStateFontFamily
- assistantStateFontSize
- assistantStateText
- assistantStateTextColor
- backgroundColor
- equalizerBarBorderRadius
- equalizerBarCount
- equalizerBarRightMargin
- equalizerBarWidth
- equalizerColor
- fullSpeechResultTextColor
- helpText
- helpTextFontColor
- helpTextFontFamily
- helpTextFontSize
- micActiveHighlightColor
- keyboardInactiveHighlightColor
- micActiveHighlightColor
- micActiveColor
- micActiveImage
- micActiveImageHeight
- micActiveImageWidth
- micBorderRadius
- micButtonHeight
- micButtonWidth
- micImageBorderColor
- micImageBorderStyle
- micImageBorderWidth
- micImageHeight
- micImagePadding
- micImageWidth
- micInactiveColor
- micInactiveHighlightColor
- micInactiveImage
- muteFontColor
- muteFontFamily
- muteFontSize
- muteImage
- muteImageColor
- muteImageHeight
- muteImageWidth
- muteText
- padding
- paddingBottom
- paddingLeft
- paddingRight
- paddingTop
- partialSpeechResultFontFamily
- partialSpeechResultFontSize
- partialSpeechResultTextColor
- placeholder
- sendActiveColor
- sendActiveImage
- sendInactiveColor
- sendInactiveImage
- speakActiveTitleColor
- speakFontFamily
- speakFontSize
- speakInactiveTitleColor
- speechResultBoxBackgroundColor
- speechResultBoxHeight
- textboxActiveHighlightColor
- textInputActiveLineColor
- textboxfontFamily
- textboxFontSize
- textboxInactiveHighlightColor
- textInputCursorColor
- textInputLineColor
- textInputTextColor
- typeActiveTitleColor
- typeFontFamily
- typeFontSize
- typeInactiveTitleColor

The following settings can be used during initialization to change the behavior of your assistant:

**serverRootUrl**: This is the Voicify assistant endpoint you want to use. The default value here is https://assistant.voicify.com, but you can also use region-specific endpoints such as https://eu-central.assistant.voicify.com.

**appId**: This is your application ID. You can get this from the Custom Assistant URL in your deployments settings page in Voicify.

**appKey**: This is your application Key aka Secret. You can get this from the Custom Assistant URL in your deployments settings page in Voicify.

**textToSpeechProvider**: This lets you choose whether you want to use Voicify's proxy to Google TTS services or AWS Polly. You can use the value of "Google" or "Polly" here.

**locale**: This is the locale you expect your user to be speaking such as en-US for English speaking American users or es-MX for Spanish speaking Mexican users.

**textToSpeechVoice**: This value indicates which specific voice from the textToSpeechProvider you want to use. For example, if you use "Polly" then you can set this value to "Brian" to use one of the male british voices. You can access a full list of Google voices [here](https://cloud.google.com/text-to-speech/docs/voices) and Polly voices [here](https://docs.aws.amazon.com/polly/latest/dg/voicelist.html). If you use "Google" reference the Google documentation. The textToSpeechVoice value should be the name in the "SSML Gender" column and the name in the "Voice name" column, separated by a pipe, like so: "female|en-US-Neural2-A". The following models are available to reference in the SDK: VoicifyAssistantGoogleTTSVoice and VoicifyAssistantPollyTTSVoice.

**channel**: This value is used in Voicify's analytics to track usages across different platforms. This is typically set to a single value, however, you can also change it for different pages or sub-domains in your website, or even make it browser specific to make tracking analytics more refined.

**device**: This is a name given for the type of device the user is one. The default recommended value here is "browser".

**initializeWithText**: Values true or false can be used here to distinguish if the textbox is focused on when the assistant is opened.

**autoRunConversation**: This value tells Voicify whether it should automatically open the microphone again in a multi-turn conversation once the assistant has finished speaking. For example, set this value to true if you want to enable hands free conversations or false if you want to give your user a chance to process what was said back to them or what was shown on the page.

**initializeWithWelcomeMessage**: This value tells Voicify whether to immediately send a welcome message response from the assistant when the user first interacts. For example, if the user clicks the button in the bottom right - if you want to play your welcome message, set this value to true. If you want to wait for the user to say something first, set it to false.

**useOutputSpeech**: This value indicates whether the assistant should speak to the user or only show the response in the UI. Set it to true to have the assistant speak back and false if not.

**useVoiceInput**: This value tells Voicify to let the user use their microphone or not. If you only want to let the user create inputs via the text box, then set this value to false. If you want the user to be able to speak to the assistant, set it to true.

**noTracking**: By setting it to false, this value allows you to turn off analytics tracking. Tracking is set to true by default.

**useDraftContent**: This value allows you to use Voicify conversation items that are in "draft" state (as opposed to only "published").

**effects**: This value allows you to pass a list of effect names that you have configured for your app. Then in the **onEffect** method, you can reference these names.

**onEffect**: This is a callback method that allows you to control what happens when an effect is triggered

**onAssistantClose**: This is a callback method that allows you to control what happens when the assistant drawer is closed

**onAssistantError**: This is a callback method that allows you to control what happens when the assistant call fails

**sessionAttributes**: This is a method that allows you to add session attributes before even opening the drawer

**userAttributes**: This is a method that allows you to add user attributes before even opening the drawer.

### Configurations

This SDK supports both "static" and "dynamic" Custom Assistant configuration code exports from the Voicify CMS Deployments page. Static configurations require users to manually update the properties passed to the AssistantDrawerUI every time a change is made to the assistant configuration inside Voicify. Dynamic onfigurations pasted into your Assistant Drawer initialization use a configurationId property to automatically sync with configuration updates inside Voicify.

What does this translate to? In short, static configurations require manual prop updates, allowing for more security, whereas dynamic configurations are updating real-time, allowing for speedier deployments.

You can read more about static and dynamic Custom Assistant configuration deployments [here](support.voicify.com/en/knowledge/how-do-i-configure-my-custom-assistant-to-dynamically-update).

#### Dynamic Deployment

Dynamic deployments can only be configured inside the Voicify CMS. The assistant can be initialized with the code export snippet provided on the Deployments page. The export will look something like this:

```swift
        AssistantDrawerUI(
          assistantSettings:
           AssistantSettingsProps(
            configurationId: "your-config-id, 
            serverRootUrl: "https://assistant.voicify.com", 
            appId: "your-app-id", 
            appKey: "your-app-key"
           )
        )
```

To override exisiting properties or to add new ones for additional customization, simply add the property to the Assistant Drawer initialization like so:

```swift
        AssistantDrawerUI(
          assistantSettings:
           AssistantSettingsProps(
            configurationId: "your-config-id, 
            serverRootUrl: "https://assistant.voicify.com", 
            appId: "your-app-id", 
            appKey: "your-app-key"
           ),
           headerProps: HeaderProps( 
              backgroundColor: "#00000000",
              assistantName: "Iron Man",
            ),
        )
```

#### Static Deployment

For example, the component can be initialized with the required settings and a few styling options.
```swift
        AssistantDrawerUI(
     assistantSettings: AssistantSettingsProps(
      serverRootUrl: "https://assistant.voicify.com",
      appId: "your-app-id",
      appKey: "your-app-secret",
      locale: "en-US",
      channel: "My App",
      device: "My device",
      textToSpeechVoice: "",
      autoRunConversation: false,
      initializeWithWelcomeMessage: true,
      textToSpeechProvider: "Google",
      useVoiceInput: true,
      useOutputSpeech: true,
      useDraftContent: false,
      noTracking: true,
      initializeWithText: false,
      backgroundColor: "#202C36,#3E77A5"
    ),
    headerProps: HeaderProps( 
      backgroundColor: "#00000000",
      assistantName: "Iron Man",
    ),
    bodyProps: BodyProps( 
      backgroundColor: "#00000000",
      messageSentTextColor: "#FFFFFF",
      messageSentBackgroundColor: "#3E77A5",
      messageReceivedTextColor: "#FFFFFF",
    ),
    toolbarProps: ToolbarProps( 
      backgroundColor: "#00000000",
      speakActiveTitleColor: "#FFFFFF",
      speakInactiveTitleColor: "#FFFFFF",
      typeActiveTitleColor: "#FFFFFF",
      typeInactiveTitleColor: "#FFFFFF",
      partialSpeechResultTextColor: "#FFFFFF",
      fullSpeechResultTextColor: "#FFFFFF",
      speechResultBoxBackgroundColor: "#3E77A5",
     )
)
```

## Create Your Own Assistant
While the Assistant Drawer UI offers a quick and easy way to integrate a Voicify Assistant, some cases may require more customization. For those cases, this SDK also provides a Voicify Assistant class that can be initialized with your `serverRootUrl`, `applicationId`, and `applicationSecret` from Voicify. Once it's configured, it becomes easy to make requests to your Voicify Custom Assistant. Additionally, the Assistant class can be configured with a TTS provider and a STT provider. In the case that you would like to use your own, you can utilize the `VoicifyTextToSpeechProvider` and `VoicifySpeechToTextProvider` classes. If you would like to utilize the providers that come with the SDK, then you can pass in the `VoicifyTTSProvider` and `VoicifySTTProvider` into the assistant

For example, the assistant class can be initialized with the required settings and provided TTS and STT classes:
```swift
var voicifyTTS = VoicifyTTSProivder(
                settings: VoicifyTextToSpeechSettings(
                appId: "your-app-id", 
                appKey: "your-app-secret", 
                voice: "", 
                serverRootUrl: "https://assistant.voicify.com", 
                provider: "Google"
                )
            )

var voicifySTT = VoicifySTTProvider()

var assistant = VoicifyAssistant(speechToTextProvider: voicifySTT,textToSpeechProvider: voicifyTTS, VoicifyAssistantSettings(
    appId = "your-app-id",
    appKey = "your-app-secret",
    serverRootUrl = "https://assistant.voicify.com",
    locale = "en-US",
    channel = "your-channel",
    device = "your-device",
    autoRunConversation = true,
    initializeWithWelcomeMessage = false,
    initializeWithText = false,
    useVoiceInput = true,
    useOutputSpeech = true))

assistant.initializeAndStart()
assistant.startNewSession()
```
## Additional Notes
There are a few things to note when using the SDK.

### Markdown
The Assistant Drawer UI component supports the ability to use markdown when displaying messages received from Voicify. In order to utilize this feature, markdown must be provided in the display text of the conversation item that is being hit. Additionally, if the markdown contains a link, it will be launched in a new safari tab.
