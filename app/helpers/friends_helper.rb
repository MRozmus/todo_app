module FriendsHelper

  def friend_shares_count(friend_id)
    Share.where(sharer_id: current_user.id, receiver_id: friend_id).count
  end

end
