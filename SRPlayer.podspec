#
# Be sure to run `pod lib lint SRPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SRPlayer'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SRPlayer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/simplismvip/SRPlayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'simplismvip' => 'tonyzhao60@gmail.com' }
  s.source           = { :git => 'https://github.com/simplismvip/SRPlayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = "5.0"
  s.source_files = 'SRPlayer/Classes/**/*'
  # OC & Swift混编添加桥接文件
  s.public_header_files = 'Pod/Classes/Define/*.h'
  # 引入IJKPlayer Framework
  s.vendored_frameworks = 'IJKMediaFramework.framework'
  s.frameworks  = "AudioToolbox", "AVFoundation", "CoreGraphics", "CoreMedia", "CoreVideo", "MobileCoreServices", "OpenGLES", "QuartzCore", "VideoToolbox", "Foundation", "UIKit", "MediaPlayer"
  s.libraries   = "bz2", "z", "stdc++"
  
  # s.resource_bundles = {
  #   'SRPlayer' => ['SRPlayer/Assets/*.png']
  # }

  s.dependency 'SnapKit'
  s.dependency 'ZJMKit'
end
