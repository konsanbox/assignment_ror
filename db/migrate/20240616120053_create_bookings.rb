class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :coach, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :starts_at, null: false

      t.timestamps
    end
  end
end
