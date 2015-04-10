class AddTranslationProduct < ActiveRecord::Migration
  def up
    product = Product.create(name: 'Translation', text: 'Dummy')
  end

  def down
    Product.where(name: 'Translation').first.destroy
  end
end
