$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "shaken_not_stirred"
  s.version     = "0.0.7"
  s.date        = "2020-06-08"
  s.summary     = "Shaken Not Stirred"
  s.description = "Ruby client to interact with Cocktails API - https://juanroldan.com.ar/cocktails-api-landing"
  s.authors     = ["Juan Roldan"]
  s.email       = "juanroldan1989@gmail.com"
  s.files       = Dir["{lib}/**/*"]
  s.homepage    = "http://rubygems.org/gems/shaken_not_stirred"
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.3.1"

  s.add_dependency "httparty", ">= 0.15.7", "< 0.22.0"

  s.add_development_dependency "vcr", "~> 3.0", ">= 3.0.3"
  s.add_development_dependency "webmock", "~> 2.3", ">= 2.3.2"
end
