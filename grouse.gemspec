# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "#{File.dirname(__FILE__)}/req/rubygems"
require 'nym'

Gem::Specification.new do |s|
  s.name = "grouse"
  s.version = CoreNYM.core_version
  s.authors = ["Takayuki Kamiyama"]
  s.email = "karuma.reason@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
  ]
  # Ignore files in mini_test and mini_unit folder.
  s.files = `git ls-files -z`.split("\x0")
  s.homepage = "https://github.com/takkii/grouse"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = ['>= 3.0']
  s.required_rubygems_version = '~> 3.6.9' if s.respond_to? CoreNYM.gem_version
  s.summary = "This project is minimum packages"
  s.description = "nyasocom_sun packages in ROR."
  s.metadata["github_repo"] = "https://github.com/takkii/grouse"

  # Use Windows ENV, speak function v4.0.4.5. exec 'bundle install'.
  s.add_runtime_dependency('sheltered-girl', '~> 4.0')

  if s.respond_to? :specification_version
    s.specification_version = 4
  end
end
