class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :eduPersonPrincipalName
      t.string :NUID
      t.string :Name
      t.string :Email
      t.string :Course
      t.decimal :GPA
      t.decimal :Score
      t.string :File_Location, unique: true
      t.string :Application_Status
      t.datetime :Interview_Time

      t.timestamps
    end
  end
  def self.down
    drop_table :sessions
  end
end
