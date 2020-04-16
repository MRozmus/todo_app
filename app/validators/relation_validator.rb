class RelationValidator < ActiveModel::Validator
  def validate(record)
    if record.sender_id == record.receiver_id
      record.errors[:base] << "Sender id couldn't be equal to receiver id"
    end
  end
end