#
#  Be sure to run `pod spec lint WFNetWorking.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #echo "2.3" > .swift-version

  s.name         = "WFNetWorking"
  s.version      = "1.0.1"
  s.summary      = "WFNetworking is a lightweight network library base on AFNetworking"

  s.homepage     = "https://github.com/crossPQW/WFNetworking"
  s.license      = "MIT"

  s.author             = { "Shaohua Huang" => "651024752@qq.com" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/crossPQW/WFNetworking.git", :tag => "1.0.1" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "WFNetworking", "WFNetworkingDemo/WFNetworking/**/*.{h,m}"

  s.dependency "AFNetworking"

end
