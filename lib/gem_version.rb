# frozen_string_literal: true

require 'open3'

module RbGemversion
  gem_version = 'gem -v'
  stdout_rb, stderr_rb, status_rb = Open3.capture3(gem_version)
  VERSION = stdout_rb.to_s
end
