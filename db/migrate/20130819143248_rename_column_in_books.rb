class RenameColumnInBooks < ActiveRecord::Migration
  def change
  	rename_column :books, :employee_id, :client_id
  end
end
