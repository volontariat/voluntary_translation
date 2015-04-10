require 'spec_helper'

describe Product::Translation::Story do
  it 'principally works' do
    story = FactoryGirl.create(:translation_story, task_factory: nil)
    
    story.columns_attributes = {
      "1381503320860"=>{"key"=>"franchises.text", "text"=>"Text", "_destroy"=>"0"}, 
      "0"=>{"key"=>"franchises.name", "text"=>"Name", "_destroy"=>"0"}
    }
    
    story.setup_tasks!
    
    story.activate!
    
    story.columns.count.should == 2
    story.tasks.count.should == 4
  end
end