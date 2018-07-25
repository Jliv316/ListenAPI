class SessionsController < ApplicationController
  def create
    token_info = TokenService.new.get_access_token(params[:code]) if params[:code]
    user_info = UserService.new.get_user_info(token_info)
    user = User.update_or_create(user_info)
    session[:id] = user.id
    current_user
    redirect_to "http://localhost:3000?token=#{user.client_token}"
  end

  def destroy
    session.clear
    redirect_to "http://localhost:3000?token=#{user.client_token}"
  end
end