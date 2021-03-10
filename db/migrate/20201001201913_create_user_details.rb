class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.string :eduPersonPrincipalName, unique: true
      t.string :DisplayName, default: 'NULL'
      t.string :Email, default: 'NULL'
      t.string :Role, default: 'Student'
      t.boolean :hasAppointment, default: '0'
      t.timestamps
    end
  end

  def self.down
    drop_table :user_details
  end
end
