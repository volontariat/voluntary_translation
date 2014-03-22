$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "voluntary_translation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "voluntary_translation"
  s.version     = VoluntaryTranslation::VERSION
  s.authors     = ["Mathias Gawlista"]
  s.email       = ["gawlista@gmail.com"]
  s.homepage    = "http://github.com/volontariat/voluntary_translation"
  s.summary     = "Translation product for crowdsourcing engine voluntary."
  s.description = "Translation product for crowdsourcing engine voluntary."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["CHANGELOG.md", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'voluntary', '~> 0.2.0'
end
