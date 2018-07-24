class AuthenticationController < ApplicationController
  def spotify
    binding.pry
    authenticator = AuthenticatorService.new
    user_info = authenticator.spotify(params[:code])
    binding.pry

    
  end

  private

  def issuer
    ENV['FLASHCARDS_CLIENT_URL']
  end
end