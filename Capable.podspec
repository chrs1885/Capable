Pod::Spec.new do |s|
  s.name = 'Capable'
  s.version = '0.8.0'
  s.summary = 'Keep track of accessibility settings and enable users with disabilities to use your iOS, tvOS, and watchOS app.'
 
  s.description = <<-DESC
Capable lets you easily keep track of accessibility settings used by your app users. Send this info along with user properties and find out about where to improve accessibility within your app. Capable also comes with additional features that will help you to solve common accessibility problems.
                       DESC
 
  s.homepage = 'https://github.com/chrs1885/Capable'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Christoph Wendt' => 'christoph.wendt@me.com' }
  s.source = { :git => 'https://github.com/chrs1885/Capable.git', :tag => s.version }
  s.documentation_url = 'http://htmlpreview.github.io/?https://github.com/chrs1885/Capable/blob/0.8.0/Documentation/index.html'
  s.swift_version = '4.2'

  s.framework = 'Foundation'
  s.ios.framework = s.tvos.framework = s.watchos.framework = 'UIKit'
  s.watchos.framework = 'WatchKit'

  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '4.0'
  
  s.subspec 'Features' do |featuresSubspec|
    s.osx.framework = 'AppKit'
    s.osx.deployment_target = '10.12'

    featuresSubspec.source_files = 'Source/Features/**/*.swift'
  end

  s.subspec 'Colors' do |colorsSubspec|
    s.osx.framework = 'AppKit'
    s.osx.deployment_target = '10.12'
    
    colorsSubspec.source_files = 'Source/Colors/**/*.swift'
  end

  s.subspec 'Fonts' do |fontsSubspec|
    fontsSubspec.source_files = 'Source/Fonts/**/*.swift'
  end
end