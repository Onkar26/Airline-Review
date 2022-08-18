class RemoveUserIdFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :userID, :string
  end
end
