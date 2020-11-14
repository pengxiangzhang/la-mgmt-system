class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.string :eduPersonPrincipalName, unique: true
      t.string :DisplayName
      t.string :Email
      t.string :Role

      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
