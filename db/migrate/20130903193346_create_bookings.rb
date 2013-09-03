class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :client_id
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
