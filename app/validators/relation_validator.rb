class RelationValidator < ActiveModel::Validator
  def validate(record)
    if record.sender_id == record.receiver_id
      record.errors[:base] << "Sender email is equal to receiver's"
    end
    if Relation.find_by(sender_id: record.sender_id, receiver_id: record.receiver_id, status: false).present?
      record.errors[:base] << "Request was sent already"
    end
    if Relation.find_by(sender_id: record.receiver_id, receiver_id: record.sender_id, status: false).present?
      record.errors[:base] << "Request was sent to you already"
    end
    if Relation.find_by(sender_id: record.sender_id, receiver_id: record.receiver_id, status: true).present? ||
      Relation.find_by(sender_id: record.receiver_id, receiver_id: record.sender_id, status: true).present?
    record.errors[:base] << "You are a friends already"
    end
  end
end