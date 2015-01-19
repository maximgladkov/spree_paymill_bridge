# coding: utf-8
version = File.read(File.expand_path("../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.name         = 'spree_paymill_bridge'
  s.version      = version
  s.author       = 'Max White'
  s.email        = 'mushishi78@gmail.com'
  s.summary      = 'Paymill gateway with javascript bridge for Spree'
  s.license      = 'MIT'
  s.files        = Dir['LICENSE.txt', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'vendor/**/*']
  s.require_path = 'lib'
  s.add_runtime_dependency 'spree_core', '2.4.2'
  s.add_runtime_dependency 'paymill', '~> 0.4', '>= 0.4.0'
  s.add_development_dependency 'rspec', '~> 3.1', '>= 3.1.0'
end
