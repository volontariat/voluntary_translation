class Product::Translation::Column < Column
  belongs_to :story, class_name: 'Product::Translation::Story', inverse_of: :column
  has_many :tasks, dependent: :destroy, class_name: 'Product::Translation::Task', inverse_of: :column
end