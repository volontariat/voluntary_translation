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
  factory :user do
    sequence(:name) { |n| "user#{n}#{r_str}" }
    sequence(:email) { |n| "user#{n}#{r_str}@volontari.at" }
    first_name 'Mister'
    last_name { |u| u.name.humanize }
    country 'Germany'
    language 'en'
    interface_language 'en'
    password 'password'
    password_confirmation { |u| u.password }
    
    #after_create do |user|
    #  User.confirm_by_token(user.confirmation_token)
    #end
  end
  
  factory :area do
    sequence(:name) { |n| "area #{n}" }
  end
  
  factory :product do
    name 'Text Creation'
    user_id FactoryGirl.create(:user, password: 'password', password_confirmation: 'password').id
    area_ids [Area.first.try(:id) || FactoryGirl.create(:area).id]
    text Faker::Lorem.sentences(5).join(' ')
    
    after_build do |product|
      product.id = product.name.to_s.parameterize
    end
    
    factory :translation_product do
      name 'Translation'
    end
  end
  
  factory :project do
    association :user
    sequence(:name) { |n| "project #{n}#{r_str}" }
    text Faker::Lorem.sentences(20).join(' ')
    
    after_build do |project|
      resource_has_many(project, :areas) 
    end
    
    factory :translation_project do
      association :product, factory: :translation_product
    end
  end
  
  factory :story, class: Product::Translation::Story do
    association :project, factory: :translation_project 
    sequence(:name) { |n| "story#{n}#{r_str}" }
    text Faker::Lorem.sentences(10).join(' ')
    input_language 'en'
    output_languages ['de', 'fr']
    event 'initialization'
    state_before 'new'
    state 'initialized'
  end
   
  factory :task do
    sequence(:name) { |n| "task#{n}#{r_str}" }
    text Faker::Lorem.sentences(10).join(' ')
  end
  
  factory :translation_task, class: Product::Translation::Task do
    sequence(:name) { |n| "task#{n}#{r_str}" }
    keywords 'Keyword 1'
  end
end
