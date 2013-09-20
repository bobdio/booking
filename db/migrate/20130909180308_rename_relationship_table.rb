class RenameRelationshipTable < ActiveRecord::Migration
  def up
  	rename_table :relationship, :relationships
  end

  def down
  	rename_table :relationship, :relationships
  end
end
