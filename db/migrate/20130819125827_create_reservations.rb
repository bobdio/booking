class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :employee_id
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
