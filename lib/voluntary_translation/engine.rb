module VoluntaryTranslation
  class Engine < ::Rails::Engine
    config.i18n.load_path += Dir[File.expand_path("../../../config/locales/**/*.{rb,yml}", __FILE__)]
  end
end
