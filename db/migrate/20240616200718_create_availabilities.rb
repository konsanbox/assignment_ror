class CreateAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.string :week_day
      t.string :start
      t.string :stop
      t.references :coach, null: false, foreign_key: true

      t.timestamps
    end
  end
end
