Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'],
  { :name => "spotify", 
    :scope => 'playlist-read-private user-read-private user-read-email user-library-read user-top-read playlist-read-private user-top-read',
    :prompt => "select_account", 
    :image_aspect_ratio => "square",
    :image_size => 50,
    :access_type => 'offline'}
end