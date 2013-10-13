class Product::Translation::Story < Story
  has_many :columns, dependent: :destroy, class_name: 'Product::Translation::Column', inverse_of: :story
  has_many :tasks, dependent: :destroy, class_name: 'Product::Translation::Task', inverse_of: :story
  
  field :input_language, type: String
  field :output_languages, type: Array
  
  validates :input_language, presence: true
  validates :output_languages, presence: true
  
  attr_accessible :input_language, :output_languages, :output_language_tokens, :columns_attributes
  
  accepts_nested_attributes_for :columns, allow_destroy: true, reject_if: ->(t) { t['key'].blank? or t['text'].blank? }
  
  after_save :create_tasks
  
  state_machine :state, initial: :new do
    state :tasks_defined do
      validates_associated :columns
      validate :presence_of_columns
    end
    
    #after_transition on: :active, do: :create_tasks
  end
  
  def self.for_user(user)
    active.where(:output_languages.in => user.languages)
  end
  
  def output_language_tokens=(tokens)
    self.output_languages = tokens.split(',')
  end
  
  def output_language_tokens
    options = []
    
    User.languages.each do |language|
      next unless (output_languages  || []).include?(language.second)
        
      options << { id: language.second, name: language.first } 
    end
    
    options
  end
  
  private
  
  def presence_of_tasks; ; end
  
  def presence_of_columns
    unless columns.any?
      errors[:base] << I18n.t(
        'activerecord.errors.models.story.attributes.base.missing_columns'
      )
    end
  end
  
  def create_tasks
    return unless state_changed? && state == 'active'
    
    output_languages.each do |output_language|
      columns.each do |column|
        tasks.create!(
          column_id: column.id, name: column.key, text: column.text,
          input_language: input_language, output_language: output_language
        )
      end
    end
  end
end