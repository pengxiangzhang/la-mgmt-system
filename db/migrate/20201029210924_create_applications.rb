class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :eduPersonPrincipalName
      t.string :NUID
      t.string :Name
      t.string :Email
      t.string :Course
      t.string :GPA
      t.string :file_location, unique: true
      t.string :application_status
      t.string :interview_time

      t.timestamps
    end
  end
end
