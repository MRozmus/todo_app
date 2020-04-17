require 'rails_helper'

RSpec.describe Relation, type: :model do
  before(:each) do
    @relation = Relation.new(sender_id: 1, receiver_id: 2)
  end
  context "on create" do
    it "should save with all attributes" do
      expect { @relation.save }.to change { Relation.count }
    end
    it "should'n save without sender_id" do 
      @relation.sender_id = nil
      expect { @relation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should'n save without receiver_id" do 
      @relation.receiver_id = nil
      expect { @relation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "should'n save with sender_id equal to receiver_id" do 
      @relation.receiver_id = 1
      expect { @relation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
