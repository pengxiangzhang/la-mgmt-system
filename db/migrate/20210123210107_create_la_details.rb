class CreateLaDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :la_details do |t|
      t.text :eduPersonPrincipalName,unique: true
      t.text :name
      t.text :course
      t.datetime :officeHour
      t.timestamps
    end

  end

  def self.down
    drop_table :la_details
  end
end
