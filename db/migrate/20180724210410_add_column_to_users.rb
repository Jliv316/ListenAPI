class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :client_token, :string
    remove_column :users, :provider
  end
end
