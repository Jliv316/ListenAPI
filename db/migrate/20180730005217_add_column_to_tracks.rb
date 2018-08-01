class AddColumnToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :top_track, :boolean, :default => false
  end
end
