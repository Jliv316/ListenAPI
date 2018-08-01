class AddTracksUrLtoPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :tracks_url, :string
  end
end
