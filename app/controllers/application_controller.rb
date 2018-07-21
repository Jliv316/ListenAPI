class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :safe_uri

  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id]
  end

  def safe_uri(uri)
    encoded_uri = URI.encode(uri)
    URI.parse(encoded_uri)
  end
end
