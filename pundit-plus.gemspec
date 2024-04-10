# frozen_string_literal: true

require_relative "lib/pundit/plus/version"

Gem::Specification.new do |spec|
  spec.name = "pundit-plus"
  spec.version = Pundit::Plus::VERSION
  spec.authors = ["Jim Gay"]
  spec.email = ["jim@saturnflyer.com"]

  spec.summary = "Pundit with additional features."
  spec.description = "Add Pundit to your application with additional features."
  spec.homepage = "https://github.com/SOFware/pundit-plus"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/SOFware/pundit-plus"
  spec.metadata["changelog_uri"] = "https://github.com/SOFware/pundit-plus/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.license = "MIT"

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "pundit"
  spec.add_dependency "pundit-matchers"
end
