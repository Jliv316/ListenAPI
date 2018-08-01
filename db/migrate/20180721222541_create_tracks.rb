class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :spotify_id
      t.integer :popularity
      t.date :release_date
      t.references :artist, foreign_key: true
      t.references :album, foreign_key: true
      t.timestamps
    end
  end
end
