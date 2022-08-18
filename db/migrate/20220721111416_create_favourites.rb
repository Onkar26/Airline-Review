class CreateFavourites < ActiveRecord::Migration[7.0]
  def change
    create_table :favourites do |t|
      t.string :userID
      t.string :airlineID

      t.timestamps
    end
  end
end
