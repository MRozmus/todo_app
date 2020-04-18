class Share < ApplicationRecord
  validates :sharer_id, :relation_id, :todo_id, presence: true
end
