class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.string :eduPersonPrincipalName
      t.string :role

      t.timestamps
    end
  end
end
