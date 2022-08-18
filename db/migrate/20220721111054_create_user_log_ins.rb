class CreateUserLogIns < ActiveRecord::Migration[7.0]
  def change
    create_table :user_log_ins do |t|
      t.string :username
      t.string :password
      t.string :contact

      t.timestamps
    end
  end
end
