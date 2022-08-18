class CreateAirlines < ActiveRecord::Migration[7.0]
  def change
    create_table :airlines do |t|
      t.string :name
      t.string :img
      t.string :avgrating
      t.string :reviewcount

      t.timestamps
    end
  end
end
