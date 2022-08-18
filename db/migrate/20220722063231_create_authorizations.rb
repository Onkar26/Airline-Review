class CreateAuthorizations < ActiveRecord::Migration[7.0]
  def change
    create_table :authorizations do |t|
      t.string :username
      t.string :status

      t.timestamps
    end
  end
end
