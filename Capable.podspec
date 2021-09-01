Pod::Spec.new do |s|
  s.name = 'Capable'
  s.version = '2.0.0'
  s.summary = 'Unified accessibility API for all Apple platforms and WCAG 2.1 conformance level calculation for color contrasts.'
 
  s.description = <<-DESC
  While Apple's accessibility API are different across all platforms and might be located in a variety of system frameworks,
  Capable offers a unified and centralized API to get the current status of accessibility settings. This info can be sent to your analytics backend to learn, if people with specific handicaps are blocked from doing certain actions within your app. Furthermore, this data will help you to prioritize accessibility work. You can also use the Capable framework for calculating high contrast colors and WCAG 2.1 color contrast conformance levels.
                       DESC
 
  s.homepage = 'https://github.com/chrs1885/Capable'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Christoph Wendt' => 'christoph.wendt@me.com' }
  s.social_media_url = 'https://twitter.com/chr_wendt'
  s.source = { :git => 'https://github.com/chrs1885/Capable.git', :tag => s.version }
  s.documentation_url = 'http://htmlpreview.github.io/?https://github.com/chrs1885/Capable/blob/1.0.0/Documentation/index.html'
  s.swift_versions = ['5.1', '5.2', '5.3']
  s.source_files = 'Source/**/*'
  
  s.framework = 'Foundation'
  s.ios.framework = s.tvos.framework = s.watchos.framework = 'UIKit'
  s.watchos.framework = 'WatchKit'
  s.osx.framework = 'AppKit'

  s.ios.deployment_target = '12.0'
  s.tvos.deployment_target = '12.0'
  s.watchos.deployment_target = '4.0'
  s.osx.deployment_target = '10.13'
end
