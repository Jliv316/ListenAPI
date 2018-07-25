class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :safe_uri

  # def current_user
  #   token = params[:token]
  #   payload = TokiToki.decode(token)
  #   @current_user ||= User.find_by(spotify_id: payload[])
  # end

  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id]
  end
  
  def logged_in?
    current_user != nil
  end

  def authenticate_user!
    head :unauthorized unless logged_in?
  end

  def safe_uri(uri)
    encoded_uri = URI.encode(uri)
    URI.parse(encoded_uri)
  end
end
