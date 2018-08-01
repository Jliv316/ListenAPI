class AddPlaylistIdtoTracks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tracks, :playlist, index: true
    add_foreign_key :tracks, :playlists
  end
end