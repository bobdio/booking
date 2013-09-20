class AddIndexToRelations < ActiveRecord::Migration
  def change
  	add_index :relationships, [:user_id, :client_id], unique: true
  end
end
