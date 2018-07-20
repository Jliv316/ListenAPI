require 'rails_helper'

RSpec.feature 'user visits homepage, enters credentials' do
  scenario 'logs in using omniauth' do
    stub_omniauth

    visit root_path
    expect(page).to have_link("Sign in with Spotify")
    click_link "Sign in with Spotify"

    expect(page).to have_content("Johnny Craig")
    expect(page).to have_content("Logout")
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      provider: "spotify",
      uid: "1263322089",
      info: {
        email: "z1685839@students.niu.edu",
        name: "Johnny Craig",
      },
      credentials: {
        token: "BQCQT8kuGYb29HHDwj2N0FU5CEApbc4GvOVAPPhAGnrfvlijAyfw_hwk-c9e3makSWK9BApYcTHQCZQ44ifr3B7FyBMAjTrqXmuY3r2hZONitgGi6ciiZbalgXZSkgMQ9EIB8dZLw5MQyJQ-X7XjMly10uOo6WMaC0G2-7RSSAUqPxbCsbZLmw",
        refresh_token: "AQCTHcmah4nCu7a8n4m8kGAML7LCfsYFHGwCPjQm0lq58gdTTIX4X5eYHtvtz2PvhIozIC7Zp_B55Q1KSJZx3ghFcXkJqaBvP0yjVcuZwtNgY0l3AXv3k8Xgeypy7zgw5TI",
        expires_at: 1530823574.seconds.from_now,
      }
    })
  end
end