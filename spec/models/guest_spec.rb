require 'rails_helper'

RSpec.describe Guest, type: :model do
  context "on create" do
    it "should save" do
      expect { Guest.create }.to change { Guest.count }
    end
  end
end
