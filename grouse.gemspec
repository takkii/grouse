# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "#{File.dirname(__FILE__)}/req/rubygems"
require 'gem_version'

Gem::Specification.new do |s|
  s.name = "grouse"
  s.version = Grs.version
  s.authors = ["Takayuki Kamiyama"]
  s.email = "karuma.reason@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
  ]
  # Ignore files in mini_test and mini_unit folder.
  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(mini_test|mini_unit)/}) }
  s.homepage = "https://github.com/takkii/grouse"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = ['>= 3.0']
  s.required_rubygems_version = '~> 3.6.9' if s.respond_to? RbGemversion::VERSION
  s.summary = "This project is minimum packages"
  s.description = "nyasocom_sun packages in ROR."
  s.metadata["github_repo"] = "https://github.com/takkii/grouse"

  # If build error case, unless Gem.win_platform?
  s.add_runtime_dependency('sheltered-girl', '~> 4.0')

  if s.respond_to? :specification_version
    s.specification_version = 4
  end
end
