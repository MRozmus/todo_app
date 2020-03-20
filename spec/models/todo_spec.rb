require 'rails_helper'

RSpec.describe Todo, type: :model do
  before(:each) do
    @guest = Guest.create
    @todo = Todo.new(title: "example_title", description: "example_description", priority: rand(0..2), status: [true, false].sample, guest_id: @guest.id)
  end
  context "on create" do
    it "should save with all attributes" do
      expect { @todo.save }.to change { Todo.count }
    end
    it "should'n save without title" do 
      @todo.title = nil
      expect { @todo.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should'n save without description" do 
      @todo.description = ""
      expect { @todo.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should'n save without priority" do 
      @todo.priority = ""
      expect { @todo.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should'n save without status" do 
      @todo.status = ""
      expect { @todo.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should'n save without guest_id" do 
      @todo.guest_id = ""
      expect { @todo.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context "guest association" do
    it "should be able to find models record" do
      @todo.save!
      expect(@todo.guest).to eq(@guest)
    end
  end
end
