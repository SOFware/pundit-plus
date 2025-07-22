# -*- encoding: utf-8 -*-
# stub: pundit-matchers 4.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "pundit-matchers".freeze
  s.version = "4.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Alley".freeze]
  s.date = "2024-12-17"
  s.description = "A set of RSpec matchers for testing Pundit authorisation policies".freeze
  s.email = "chris@chrisalley.info".freeze
  s.homepage = "https://github.com/pundit-community/pundit-matchers".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1".freeze)
  s.rubygems_version = "3.5.22".freeze
  s.summary = "RSpec matchers for Pundit policies".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<rspec-core>.freeze, ["~> 3.12".freeze])
  s.add_runtime_dependency(%q<rspec-expectations>.freeze, ["~> 3.12".freeze])
  s.add_runtime_dependency(%q<rspec-mocks>.freeze, ["~> 3.12".freeze])
  s.add_runtime_dependency(%q<rspec-support>.freeze, ["~> 3.12".freeze])
end
