
Pod::Spec.new do |spec|
  spec.name         = "voicify-assistant-sdk"
  spec.version      = "0.0.6"
  spec.summary      = "A voicify assistant framework"
  spec.description  = <<-DESC
                        "deploy your voicify app to mobile IOS apps"
                   DESC

  spec.homepage     = "https://github.com/voicifydevs/voicify-ios-sdk"
  spec.license      = "MIT"
  spec.author             = { "James" => "jmccarthy@voicify.com" }
  spec.platform     = :ios, "14.0"
  spec.source       = { :git => "https://github.com/voicifydevs/voicify-ios-sdk.git", :tag => spec.version.to_s }
  spec.source_files  = "voicify-ios-sdk/**/*.{swift}"
  spec.swift_versions = "5.0"
  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
