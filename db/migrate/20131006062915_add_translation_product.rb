class AddTranslationProduct < ActiveRecord::Migration
  def up
    area = Area.where(name: 'General').first
    
    product = Product.new(name: 'Translation', text: 'Dummy', area_ids: [area.id])
    product.user_id = User.where(name: 'Master').first.id
    product.save!
  end

  def down
    Product.where(name: 'Translation').first.destroy
  end
end
