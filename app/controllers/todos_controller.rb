class TodosController < ApplicationController
  before_action :set_guest
  before_action :todo_find, only: [:show, :edit, :status]
  before_action :todos_find, only: [:index, :status]

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
      flash[:alert] = todo.errors.full_messages
      redirect_to new_todo_path
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
    todo.destroy
    flash[:notice] = "#{todo.title} deleted!"
    redirect_to todos_path
  end

  def status
    @todo.update(status: @todo.status == false ? true : false)
    flash.now[:notice] = "#{@todo.title} #{@todo.status == false ? "to do!" : "done!"}"
  end

  private

  def set_guest
    if session[:guest_id].nil?
      guest = Guest.create
      session[:guest_id] = guest.id
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :priority, :status, :guest_id)
  end

  def todo_find
    @todo = Todo.find(params[:id])
    redirect_to todos_path if @todo.guest.id != session[:guest_id]
  end

  def todos_find
    @todos = Guest.find(session[:guest_id]).todos
  end
end
