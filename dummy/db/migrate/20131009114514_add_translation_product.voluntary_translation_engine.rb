# This migration comes from voluntary_translation_engine (originally 20131006062915)
class AddTranslationProduct < ActiveRecord::Migration
  def up
    product = Product.create(name: 'Translation', text: 'Dummy')
  end

  def down
    Product.where(name: 'Translation').first.destroy
  end
end
