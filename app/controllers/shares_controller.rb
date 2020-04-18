class SharesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_shares, only: :index
  before_action :find_share, only: :show
  before_action :find_relation, only: [:create, :destroy]

  def index
  end

  def show
  end

  def create
    share = Share.new(sharer_id: params[:sharer_id], relation_id: @relation.id, todo_id: params[:todo_id], receiver_id: params[:friend_id])
    if share.save
      flash[:notice] = "#{Todo.find(share.todo_id).title} shared successful to #{User.find(params[:friend_id]).email}"
      redirect_to todo_path(share.todo_id)
    else
      flash[:alert] = share.errors.full_messages
      redirect_to todo_path(share.todo_id)
    end
  end

  def destroy
    share = Share.find_by(sharer_id: params[:sharer_id], relation_id: @relation.id, todo_id: params[:todo_id], receiver_id: params[:friend_id])
    if share.destroy
      if share.receiver_id == current_user.id
        flash[:notice] = "You had dismiss #{Todo.find(share.todo_id).title}"
        redirect_to shares_path
      else
        flash[:notice] = "#{Todo.find(share.todo_id).title} is no more shared to #{User.find(params[:friend_id]).email}"
        redirect_to todo_path(share.todo_id)
      end
    else
      if share.receiver_id == current_user.id
        flash[:alert] = share.errors.full_messages
        redirect_to shares_path
      else
        flash[:alert] = share.errors.full_messages
        redirect_to todo_path(share.todo_id)
      end
    end
  end

  private

  def find_shares
    todo_ids = []
    Share.where(receiver_id: current_user.id).each do |share|
      todo_ids << share.todo_id
    end
    @todos = Todo.where(id: todo_ids)
  end

  def find_share
    @todo = Todo.find_by(id: params[:id])
    redirect_to shares_path if Share.find_by(todo_id: params[:id], receiver_id: current_user.id).nil?
  end

  def find_relation
    Relation.find_by(sender_id: params[:sharer_id], receiver_id: params[:friend_id]).nil? ?
    @relation = Relation.find_by(sender_id: params[:friend_id], receiver_id: params[:sharer_id]) :
    @relation = Relation.find_by(sender_id: params[:sharer_id], receiver_id: params[:friend_id])
  end

end
