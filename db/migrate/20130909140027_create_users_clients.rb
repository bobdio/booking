class CreateUsersClients < ActiveRecord::Migration
  def change
    create_table :users_clients do |t|
      t.integer :user_id
      t.integer :client_id
      t.integer :confirm

      t.timestamps
    end
  end
end
