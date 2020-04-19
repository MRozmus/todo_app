module ApplicationHelper

  def requests?(current_user_id)
    relations = Relation.where(receiver_id: current_user_id, status: false).count
    relations == 0 ? "" : " <span class='badge badge-info'>#{relations}</span>"
  end

  def shares_count(current_user_id)
    todo_ids = []
    Share.where(receiver_id: current_user.id).each do |share|
      todo_ids << share.todo_id
    end
    " <span class='badge badge-light'>#{Todo.where(id: todo_ids).count}</span>"
  end

end
