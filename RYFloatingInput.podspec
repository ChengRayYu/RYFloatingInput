#
# Be sure to run `pod lib lint RYFloatingInput.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RYFloatingInput'
  s.version          = '0.1.1'
  s.summary          = 'A customizable and flexible textfield control written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       RYFlotingInput, inspired by "Floating Label Pattern" and implemented with RxSwift & mvvm pattern, provides a fully-customizable textfield input control along with painless input text validation.
                       DESC

  s.homepage         = 'https://github.com/ycray/RYFloatingInput'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ray ChengJui YU' => 'eebolue@gmail.com' }
  s.source           = { :git => 'https://github.com/ycray/RYFloatingInput.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = ['RYFloatingInput/Classes/**/*', 'RYFloatingInput/Assets/**/*']
  # s.resource_bundles = {
  #   'RYFloatingInput' => ['RYFloatingInput/Assets/*.*']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'RxCocoa', '~> 4.0'
end
