#
# Be sure to run `pod lib lint HJSExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HJSExtension'
  s.version          = '0.1.3'
  s.summary          = '开发过程中常用的一些扩展方法，以及部分自定义类。OC版本.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MyColourfulLife/HJSExtension.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huangjiashu' => '1107660581@qq.com' }
  s.source           = { :git => 'https://github.com/MyColourfulLife/HJSExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'HJSExtension/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HJSExtension' => ['HJSExtension/Assets/*.png']
  # }

   s.public_header_files = 'Pod/Classes/**/*'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
