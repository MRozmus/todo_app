class Relation < ApplicationRecord
  validates :sender_id, :receiver_id, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates_with RelationValidator
end
