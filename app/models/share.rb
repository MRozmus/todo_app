class Share < ApplicationRecord
  has_one :todo
  validates :sharer_id, :relation_id, :todo_id, :receiver_id, presence: true
end
