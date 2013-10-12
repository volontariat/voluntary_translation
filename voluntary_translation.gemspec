$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "voluntary_translation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "voluntary_translation"
  s.version     = VoluntaryTranslation::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of VoluntaryTranslation."
  s.description = "TODO: Description of VoluntaryTranslation."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'voluntary', '0.1.0'
end
