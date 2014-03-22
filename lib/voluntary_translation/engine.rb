module VoluntaryTranslation
  class Engine < ::Rails::Engine
    config.i18n.load_path += Dir[File.expand_path("../../../config/locales/**/*.{rb,yml}", __FILE__)]
    
    config.to_prepare do
      Voluntary::Navigation::Base.add_product('translation', 'workflow.user.products.translation.title')
    end
  end
end
