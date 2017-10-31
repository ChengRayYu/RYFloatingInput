Pod::Spec.new do |s|
  s.name             = 'RYFloatingInput'
  s.version          = '0.1.3'
  s.summary          = 'A customizable and flexible textfield control written in Swift.'
  s.description      = <<-DESC
                       RYFlotingInput, inspired by "Floating Label Pattern" and implemented with RxSwift & mvvm pattern, provides a fully-customizable textfield input control along with painless input text validation.
                       DESC

  s.homepage         = 'https://github.com/ycray/RYFloatingInput'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ray ChengJui YU' => 'eebolue@gmail.com' }
  s.source           = { :git => 'https://github.com/ycray/RYFloatingInput.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

s.source_files = ['RYFloatingInput/Classes/**/*', 'RYFloatingInput/Assets/**/*']
  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'RxCocoa', '~> 4.0'
end
