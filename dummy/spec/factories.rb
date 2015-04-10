def r_str
  SecureRandom.hex(3)
end

def resource_has_many(resource, association_name)
  association = if resource.send(association_name).length > 0
    nil
  elsif association_name.to_s.classify.constantize.count > 0
    association_name.to_s.classify.constantize.last
  else
    Factory.create association_name.to_s.singularize.to_sym
  end
  
  resource.send(association_name).send('<<', association) if association
end

FactoryGirl.define do
  Voluntary::Test::RspecHelpers::Factories.code.call(self)
  
  factory :translation_product, parent: :product, class: Product::Translation do
    name 'Translation'
  end
  
  factory :translation_project, parent: :project do
    association :product, factory: :translation_product
  end
  
  factory :translation_story, parent: :story, class: Product::Translation::Story do
    association :project, factory: :translation_project
      
    input_language 'en'
    output_languages ['de', 'fr']  
      
    ignore { task_factory :translation_task }
  end
  
  factory :translation_task, parent: :task, class: Product::Translation::Task do
  end
end
