class ChangeDescriptionFormatInHomes < ActiveRecord::Migration
  def up
  	change_column :homes, :description, :text
  end

  def down
  	change_column :homes, :description, :string
  end
end
