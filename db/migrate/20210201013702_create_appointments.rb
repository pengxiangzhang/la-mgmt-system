class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :eduPersonPrincipalName
      t.string :displayName
      t.string :email
      t.datetime :datetime
      t.string :class_id
      t.string :method
      t.integer :duration
      t.string :la_eduPersonPrincipalName
      t.datetime :la_accept_time
      t.string :status
      t.text :notes
      t.string :location
      t.timestamps
    end
  end
end
