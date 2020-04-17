class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :friends_find, only: :index
  before_action :friend_find, only: :show

  def index
  end
  
  def show
  end

  def new
  end

  def create
    receiver = User.find_by(email: params[:email])
    unless receiver.nil?
      relation = Relation.new(sender_id: params[:sender_id], receiver_id: receiver.id)
      if relation.save
        flash[:notice] = "Request sent to #{receiver.email}, wait for acceptance !"
        redirect_to friends_path
      else
        flash[:alert] = relation.errors.full_messages
        redirect_to new_friend_path
      end
    else
      params[:email].blank? ? flash[:alert] = "Field can't be blank" : flash[:alert] = "We couldn't find #{params[:email]}"
      redirect_to new_friend_path
    end
  end

  def destroy
    user = User.find(params[:id])
    Relation.find_by(sender_id: current_user.id, receiver_id: user.id).nil? ?
    Relation.find_by(sender_id: user.id, receiver_id: current_user.id).destroy :
    Relation.find_by(sender_id: current_user.id, receiver_id: user.id).destroy
    flash[:notice] = "#{user.email} isn't your friend no more!"
    redirect_to friends_path
  end

  def status
    relation = Relation.find(params[:relation_id])
    if relation.update(status: true)
      flash[:notice] = "Request from #{User.find(relation.sender_id).email} accepted!"
      redirect_to friends_path
    else
      flash[:alert] = relation.errors.full_messages
      redirect_to friends_path
    end
  end

  private

  def friends_find
    relations_true = Relation.where(sender_id: current_user.id, status: true).or(Relation.where(receiver_id: current_user.id, status: true))
    @relations_false = Relation.where(receiver_id: current_user.id, status: false)
    friends_id = []
    relations_true.each do |relation|
      relation.sender_id == current_user.id ? friends_id << relation.receiver_id : friends_id << relation.sender_id
    end
    @friends = User.where(id: friends_id)
  end

  def friend_find
    if User.find_by(id: params[:id]).present?
      @friend = User.find(params[:id])
      redirect_to friends_path if Relation.find_by(sender_id: current_user.id, receiver_id: @friend.id).nil? && Relation.find_by(sender_id: @friend.id, receiver_id: current_user.id).nil?
    else
      redirect_to friends_path
    end
  end
end
