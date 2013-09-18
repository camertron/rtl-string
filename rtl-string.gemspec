$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rtl-string/version'

Gem::Specification.new do |s|
  s.name     = "rtl-string"
  s.version  = ::RtlString::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["cdutro@twitter.com"]
  s.homepage = "https://github.com/camertron"

  s.description = s.summary = "Easier string manipulation for people who come from LTR backgrounds."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'twitter_cldr'

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "LICENSE", "Rakefile", "rtl-string.gemspec"]
end
