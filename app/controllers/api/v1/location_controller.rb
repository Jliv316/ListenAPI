module Api::V1
  class LocationController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
      current_user
      location = {lat: params[:location][:latitude], lng: params[:location][:longitude]}
      current_user.location_data = location
      current_user.save
    end
  end
end