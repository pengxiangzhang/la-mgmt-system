class CreateLaDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :la_details do |t|
      t.string :eduPersonPrincipalName, unique: true
      t.string :name
      t.string :course
      t.string :Monday
      t.string :Tuesday
      t.string :Wednesday
      t.string :Thursday
      t.string :Friday
      t.string :Saturday
      t.string :Sunday
      t.boolean :allowChangeHour
      t.text :announcement
      t.string :location
      t.timestamps
    end

  end

  def self.down
    drop_table :la_details
  end
end
