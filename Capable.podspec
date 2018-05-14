Pod::Spec.new do |s|
  s.name             = 'Capable'
  s.version          = '0.1.3'
  s.summary          = 'Keep track of accessibility settings and enable users with disabilities to use your iOS, tvOS, and watchOS app.'
 
  s.description      = <<-DESC
Capable lets you easily keep track of accessibility settings used by your app users. Send this info along with user properties and find out about where to improve accessibility within your app. Capable also comes with additional features that will help you to solve common accessibility problems.
                       DESC
 
  s.homepage         = 'https://github.com/chrs1885/Capable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christoph Wendt' => 'christoph.wendt@me.com' }
  s.source           = { :git => 'https://github.com/chrs1885/Capable.git', :tag => s.version }
  s.swift_version = '4.1'
  s.source_files = 'Source/**/*.swift'

  s.framework      = 'UIKit', 'Foundation'
  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '2.0'
  s.watchos.framework  = 'WatchKit'
end