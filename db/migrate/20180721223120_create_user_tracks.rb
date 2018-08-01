class CreateUserTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tracks do |t|
      t.references :user, foreign_key: true
      t.references :track, foreign_key: true
      t.datetime :added_at
    end
  end
end
