# frozen_string_literal: true
source "https://rubygems.org"

puts "Current Bundler version #{Gem::Version.new(Bundler::VERSION)}"

if Gem::Version.new(Bundler::VERSION) != Gem::Version.new('1.17.1')
  abort "Bundler version 1.17.1 is required, please install 'gem install bundler --version=1.17.1'"
end
gem "tracker_deliveries", "~> 1.0.1"

gem "fastlane", "2.137.0"

gem "cocoapods", "1.7.5"

gem "xcode-install"

gem "xcov", "1.7.0"

gem "trainer"

gem "git"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
