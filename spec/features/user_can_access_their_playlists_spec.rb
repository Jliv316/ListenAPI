require 'rails_helper'

describe 'user logs in' do
  it 'displays users playlists' do
    auth = 
      {
        provider: "spotify",
        uid: "1263322089",
        info: {
          email: "z1685839@students.niu.edu",
          name: "Johnny Craig",
        },
        credentials: {
          token: "BQCQT8kuGYb29HHDwj2N0FU5CEApbc4GvOVAPPhAGnrfvlijAyfw_hwk-c9e3makSWK9BApYcTHQCZQ44ifr3B7FyBMAjTrqXmuY3r2hZONitgGi6ciiZbalgXZSkgMQ9EIB8dZLw5MQyJQ-X7XjMly10uOo6WMaC0G2-7RSSAUqPxbCsbZLmw",
          refresh_token: "AQCTHcmah4nCu7a8n4m8kGAML7LCfsYFHGwCPjQm0lq58gdTTIX4X5eYHtvtz2PvhIozIC7Zp_B55Q1KSJZx3ghFcXkJqaBvP0yjVcuZwtNgY0l3AXv3k8Xgeypy7zgw5TI",
          expires_at: 10.minutes.ago}
      }
    User.update_or_create(auth)
    user = User.first
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("user_playlists") do
      playlist_service = PlaylistService.new(user)
      user_playlists = playlist_service.playlists

      expect(user_playlists.first.name).to eq("July 2018")
      expect(user_playlists[1].name).to eq("June 2018")
    end
  end
end