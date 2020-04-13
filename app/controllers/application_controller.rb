class ApplicationController < ActionController::Base
  before_action :set_guest
  
  private

  def set_guest
    guest_expire
    if session[:guest_id].nil?
      guest = Guest.create
      session[:guest_id] = guest.id
    end
  end
  
  def guest_expire
    unless session[:guest_id].nil?
      guest = Guest.find(session[:guest_id])
      if (Time.now.to_i - guest.created_at.to_i) > 86399
        guest.todos.each do |todo|
          todo.delete if todo.user_id == nil
        end
        guest.delete
        session[:guest_id] = nil
      end
    end
  end

end
