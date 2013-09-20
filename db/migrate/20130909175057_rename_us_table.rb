class RenameUsTable < ActiveRecord::Migration
  def up
  	rename_table :users_clients, :relationship
  end

  def down
  	rename_table :relationship, :users_clients
  end
end
