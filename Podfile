platform :ios, '10.0'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

workspace 'Leknes'

project 'Leknes.xcodeproj'

def shared_pods
  pod 'RxSwift',                 '~> 5.0'
  pod 'RxCocoa',                 '~> 5.0'
  pod 'RxDataSources',           '~> 4.0'
  pod 'RxGesture',               '~> 3.0'
  pod 'RxOptional',              '~> 4.0'
  pod 'RxRealm',                 '~> 1.0', :inhibit_warnings => true

  pod 'SwiftLint',               '~> 0.33.0'
end

def shared_test_pods
  use_frameworks! # Required for Swift Test Targets only
  inherit! :search_paths # Required for not double-linking libraries in the app and test targets.
  
  pod 'Quick', '2.1.0'
  pod 'Nimble', '8.0.2'
  pod 'RxBlocking', '~> 5'
  pod 'RxTest',     '~> 5'
  pod 'OHHTTPStubs/Swift', '~> 6.0.0'
  pod 'RxDataSources',           '~> 4.0'
end

target 'Leknes' do
  shared_pods
end

target 'LeknesTests' do
  shared_test_pods
end
