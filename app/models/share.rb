class Share < ApplicationRecord
  validates :sharer_id, :relation_id, :todo_id, :receiver_id, presence: true
end
