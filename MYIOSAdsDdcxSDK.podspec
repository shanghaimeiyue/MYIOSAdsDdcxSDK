#
# Be sure to run `pod lib lint MYIOSAdsDdcxSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MYIOSAdsDdcxSDK'
  s.version          = '1.0.0'
  s.summary          = 'A short description of MYIOSAdsDdcxSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/shanghaimeiyue/MYIOSAdsDdcxSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shanghaimeiyue' => 'karl@edimob.com' }
  s.source           = { :git => 'https://github.com/shanghaimeiyue/MYIOSAdsDdcxSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.static_framework = true
  s.resources = 'MYIOSAdsDdcxSDK/Resources/MYAdsBundle.bundle'
  s.vendored_frameworks = 'MYIOSAdsDdcxSDK/Frameworks/EdiMobSDK.framework','MYIOSAdsDdcxSDK/Frameworks/KSCrash.framework','MYIOSAdsDdcxSDK/Frameworks/MYAdsFramework.framework'
  
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => ['-ObjC' , '-all_load', '-ld64'], 'VALID_ARCHS[sdk=iphonesimulator*]' => '' }
  
  s.dependency 'GDTMobSDK', '4.14.76'
  s.dependency 'KSAdSDK', '3.3.65'
  s.dependency 'WechatOpenSDK_UnPay'
  s.dependency 'SDWebImage'
  s.dependency 'Masonry'
  
end
