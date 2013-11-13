class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :email
      t.string :name
      t.date :arrival
      t.date :departure
      t.integer :days
      t.integer :adults
      t.integer :youngsters
      t.string :phone
      t.string :mobile

      t.timestamps
    end
  end
end
