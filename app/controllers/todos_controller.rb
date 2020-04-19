class TodosController < ApplicationController
  before_action :todo_find, only: [:show, :edit, :status]
  before_action :todos_find, :todos_sort, only: [:index, :status]
  before_action :friends_find, only: :show


  def index
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      flash[:notice] = "#{todo.title} added!"
      redirect_to todo_path(todo.id)
    else
      flash.now[:alert] = todo.errors.full_messages
    end
  end

  def edit
  end

  def update
    todo = Todo.find(params[:id])
    if todo.update(todo_params)
      flash[:notice] = "#{todo.title} edited!"
      redirect_to todo_path(todo.id)
    else
      flash[:alert] = todo.errors.full_messages
      redirect_to edit_todo_path(todo.id)
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    Share.where(todo_id: todo.id).each {|share| share.destroy}
    todo.destroy
    flash[:notice] = "#{todo.title} deleted!"
    redirect_to todos_path
  end

  def status
    if params[:from] == "share"
      @todo.update(status: @todo.status == false ? true : false)
      flash[:notice] = "#{@todo.title} #{@todo.status == false ? "to do!" : "done!"}"
      redirect_to shares_path
    else
      @todo.update(status: @todo.status == false ? true : false)
      flash.now[:notice] = "#{@todo.title} #{@todo.status == false ? "to do!" : "done!"}"
    end
  end

  def migrate
    todos = Todo.where(guest_id: session[:guest_id], user_id: nil)
    todos.each {|todo| todo.update(guest_id: nil ,user_id: current_user.id)}
    flash[:notice] = "Todos migrated!"
    redirect_to todos_path
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :priority, :status, :guest_id, :user_id)
  end

  def todo_find
    if Todo.find_by(id: params[:id]).present?
      @todo = Todo.find(params[:id])
      if user_signed_in?
        redirect_to todos_path if @todo.user_id != current_user.id && Share.find_by(sharer_id: @todo.user_id, todo_id: @todo.id, receiver_id: current_user.id).nil?
      else
        redirect_to todos_path if @todo.guest.id != session[:guest_id]
      end
    else
      redirect_to todos_path
    end
  end

  def todos_find
    if user_signed_in?
      @todos = Todo.where(user_id: current_user.id)
    else
      @todos = Guest.find(session[:guest_id]).todos
    end
  end

  def todos_sort
    if params[:sort]
      params[:sort] = "title" unless Todo::SORT.include?(params[:sort])
      @sort = params[:sort]
    else
      @sort = "title"
    end
  end

  def friends_find
    if user_signed_in?
      relations_true = Relation.where(sender_id: current_user.id, status: true).or(Relation.where(receiver_id: current_user.id, status: true))
      @relations_false = Relation.where(receiver_id: current_user.id, status: false)
      friends_id = []
      relations_true.each do |relation|
        relation.sender_id == current_user.id ? friends_id << relation.receiver_id : friends_id << relation.sender_id
      end
      @friends = User.where(id: friends_id)
    end
  end

end
