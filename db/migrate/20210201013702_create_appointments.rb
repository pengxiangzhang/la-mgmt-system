class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :eduPersonPrincipalName
      t.string :displayName
      t.string :email
      t.datetime :datetime
      t.string :class_id
      t.string :the_method
      t.integer :duration
      t.string :la_eduPersonPrincipalName
      t.datetime :la_accept_time
      t.string :status
      t.text :notes
      t.text :close_reason
      t.string :location
      t.datetime :startTime
      t.datetime :endTime
      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
