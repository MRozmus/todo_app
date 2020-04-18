module SharesHelper

  def shared?(sharer_id, friend_id, todo_id)
    Relation.find_by(sender_id: sharer_id, receiver_id: friend_id).nil? ?
    relation = Relation.find_by(sender_id: friend_id, receiver_id: sharer_id) :
    relation = Relation.find_by(sender_id: sharer_id, receiver_id: friend_id)
    Share.find_by(sharer_id: sharer_id, relation_id: relation.id, todo_id: todo_id, receiver_id: friend_id)
  end

end
