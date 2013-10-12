class Product::Translation::Task < ::Task
  belongs_to :story, class_name: 'Product::Translation::Story', inverse_of: :task
  belongs_to :column, class_name: 'Product::Translation::Column', inverse_of: :task
  
  field :input_language, type: String
  field :output_language, type: String
  
  validates :text, presence: true
  validates :input_language, presence: true
  validates :output_language, presence: true
  
  attr_accessible :input_language, :output_language
  
  protected
  
  # validates :name, presence: true, uniqueness: { scope: [:story_id, :output_language] }
  def name_valid?
    if name.present?
      if Task.where(name: name, story_id: story_id, output_language: output_language).any?
        errors.add(:name, I18n.t('errors.messages.taken'))
      end
    else
      errors.add(:name, I18n.t('errors.messages.blank'))
    end
  end
end