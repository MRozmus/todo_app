class Relation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  validates :sender_id, :receiver_id, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates_with RelationValidator
end
