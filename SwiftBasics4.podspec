
Pod::Spec.new do |s|

  s.name         = "SwiftBasics4"
  s.version      = "0.0.1"
  s.summary      = "Swift4.0 Basics"

  s.description  = <<-DESC
                   Swift4.0 Basics
                   DESC

  s.homepage     = "https://github.com/hw3308/SwiftBasics4.git"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "hw" => "hw3308@sina.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  s.platform     = :ios
  s.platform     = :ios, "9.0"

  s.ios.deployment_target = "9.0"



  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  s.source = { :git => "https://github.com/hw3308/SwiftBasics4", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  s.source_files  = "SwiftBasics4","SwiftBasics4/**/*.{h,m}","SwiftBasics4/**/*.swift"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #



  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  s.requires_arc = true

s.dependency 'SwiftyJSON'
s.dependency 'KeychainSwift'
s.dependency 'ObjectMapper'
s.dependency 'RealmSwift'
s.dependency 'Realm'
s.dependency 'Alamofire'
s.dependency 'AlamofireObjectMapper'
s.dependency 'ReachabilitySwift'
s.dependency 'Kingfisher'
end
