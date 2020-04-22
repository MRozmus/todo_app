class Share < ApplicationRecord
  has_one :todo
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  validates :sharer_id, :relation_id, :todo_id, :receiver_id, presence: true
end
