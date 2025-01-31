Pod::Spec.new do |s|
  s.name             = 'paystack_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A Paystack Flutter plugin for accepting payments.'
  s.description      = <<-DESC
A Paystack Flutter plugin for accepting payments.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Paystack Developer Relations' => 'devrel@paystack.com' }
  s.source           = { :path => '.' }
  # s.source_files = 'Classes/**/*'
  s.platform = :ios, '14.0'
  s.source_files = 'sample_sdk/Sources/sample_sdk/**/*.swift'
  s.dependency 'Flutter'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  
  # SPM config
  s.swift_version = '5.9'
  s.preserve_paths = 'Package.swift', '.swiftpm/**/*'
  s.prepare_command = <<-CMD
    swift pacakge resolve
  CMD
end
