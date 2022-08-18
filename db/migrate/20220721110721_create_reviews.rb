class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :airlineID
      t.string :userID
      t.string :rating
      t.string :heading
      t.string :description

      t.timestamps
    end
  end
end
