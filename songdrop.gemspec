# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{songdrop}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Taylor"]
  s.date = %q{2013-07-09}
  s.description = %q{songdrop is a Ruby client for the Songdrop.com API.}
  s.email = %q{moomerman@gmail.com}
  s.files = ["LICENSE", "README.md","lib/songdrop.rb"] + Dir.glob('lib/songdrop/*.rb') + Dir.glob('lib/songdrop/*/*.rb')
  s.has_rdoc = false
  s.homepage = %q{https://api.songdrop.com/}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{songdrop}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{songdrop is a Ruby client for the Songdrop.com API.}
end
