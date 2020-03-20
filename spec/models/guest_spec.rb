require 'rails_helper'

RSpec.describe Guest, type: :model do
  context "on create" do
    it "should save" do
      expect { Guest.create }.to change { Guest.count }
    end
  end
  context "todo association" do
    it "should be able to find models record" do
      guest = Guest.create
      todo = Todo.create(title: "example_title", description: "example_description", priority: rand(0..2), status: [true, false].sample, guest_id: guest.id)
      expect(guest.todos).to include(todo)
    end
  end
end
