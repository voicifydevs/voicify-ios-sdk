#
#  Be sure to run `pod spec lint voicify-ios-sdk.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "voicify-ios-sdk"
  spec.version      = "1.0.1"
  spec.summary      = "Voicify Assistant SDK"
  spec.description  = <<-DESC
                    "Deploy your voicify app to your IOS mobile app."
                   DESC

  spec.homepage     = "https://github.com/voicifydevs/voicify-ios-sdk"
  spec.license      = ""
  spec.author       = { "voicifydevs" => "jmccarthy@voicify.com"}
  spec.platform     = :ios, "14.0"
  spec.source       = { :git => "https://github.com/voicifydevs/voicify-ios-sdk.git", :tag => spec.version.to_s }
  spec.source_files  = "src/voicify-assistant-sdk/voicify-assistant-sdk/**/*.{swift}"
  spec.swift_versions = "5.0"
  spec.dependency 'BottomSheet'
  spec.dependency 'Kingfisher'
end
