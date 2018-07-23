class SessionsController < ApplicationController
  def create
    user = User.update_or_create(request.env['omniauth.auth'])
    session[:id] = user.id
    current_user

    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end