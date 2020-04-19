module ApplicationHelper

  def requests?(current_user_id)
    relations = Relation.where(receiver_id: current_user_id, status: false).count
    relations == 0 ? "" : " <span class='badge badge-info'>#{relations}</span>"
  end

  def shares_count(current_user_id)
    " <span class='badge badge-light'>#{Share.where(receiver_id: current_user.id).count}</span>"
  end

end
