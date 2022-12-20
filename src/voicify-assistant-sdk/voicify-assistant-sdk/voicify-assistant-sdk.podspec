Pod::Spec.new do |s|
    s.name             = 'voicify-assistant-sdk'  
    s.version          = '0.0.4'  
    s.summary          = 'Voicify Assistant sdk' 
    s.description      = <<-DESC 
            Deploy your voice assistant to your IOS mobile app!
    DESC
    s.homepage         = 'https://github.com/voicifydevs/voicify-ios-sdk'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'username' => 'voicifydevs' } 
    s.source           = { :git => 'https://github.com/voicifydevs/voicify-ios-sdk.git', :tag => s.version.to_s } 
    s.ios.deployment_target = '14.0'
    s.vendored_frameworks = 'voicify-ios-sdk/src/voicify-assistant-sdk/products/voicify_assistant_sdk.framework'
    s.swift_version = '5.0'
    end