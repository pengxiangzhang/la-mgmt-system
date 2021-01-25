class CreateLaOfficeHours < ActiveRecord::Migration[5.2]
  def change
    create_table :la_office_hours do |t|
      t.text :eduPersonPrincipalName,unique: true
      t.text :course
      t.datetime :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :la_office_hours
  end
end
