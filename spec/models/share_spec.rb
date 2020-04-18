require 'rails_helper'

RSpec.describe Share, type: :model do
  before(:each) do
    @share = Share.new(sharer_id: 1, relation_id: 2, todo_id: 3)
  end
  context "on create" do
    it "should save with all attributes" do
      expect { @share.save }.to change { Share.count }
    end
    it "should'n save without sharer_id" do 
      @share.sharer_id = nil
      expect { @share.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should'n save without relation_id" do 
      @share.relation_id = nil
      expect { @share.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should'n save without todo_id" do 
      @share.todo_id = nil
      expect { @share.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
