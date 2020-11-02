class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.string :eduPersonPrincipalName, unique: true
      t.string :displayName
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end
