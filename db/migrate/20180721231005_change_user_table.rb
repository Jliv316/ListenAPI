class ChangeUserTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :uid, :spotify_id
  end
end
