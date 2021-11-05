#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_vgs.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_vgs'
  s.version          = '0.0.1'
  s.summary          = 'A flutter VGS show plugin.'
  s.description      = <<-DESC
  A flutter VGS show plugin.
                       DESC
  s.homepage         = 'http://djamo.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Djamo' => 'josue.kouakou@djamo.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'VGSShowSDK'
  s.platform = :ios, '10.0'
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
