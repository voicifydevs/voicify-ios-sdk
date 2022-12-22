#
#  Be sure to run `pod spec lint voicify-ios-sdk.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "voicify-ios-sdk"
  spec.version      = "0.2.0"
  spec.summary      = "Voicify Assistant SDK"
  spec.description  = <<-DESC
                    "Deploy your voicify app to your IOS mobile app."
                   DESC

  spec.homepage     = "https://github.com/voicifydevs/voicify-ios-sdk"
  spec.license      = "MIT"
  spec.author       = { "voicifydevs" => "jmccarthy@voicify.com"}
  spec.platform     = :ios, "14.0"
  spec.source       = { :git => "https://github.com/voicifydevs/voicify-ios-sdk.git", :tag => spec.version.to_s }
  spec.source_files  = "src/voicify-assistant-sdk/voicify-assistant-sdk/**/*.{swift}"
  spec.swift_versions = "5.0"
  spec.dependency "KingFisher"
  spec.dependency "BottomSheet"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
