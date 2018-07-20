class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :oauth_expires_at, :token_exp
  end
end
