class CreateLaDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :la_details do |t|
      t.string :eduPersonPrincipalName, unique: true
      t.string :name
      t.string :course
      t.text :Monday
      t.text :Tuesday
      t.text :Wednesday
      t.text :Thursday
      t.text :Friday
      t.text :Saturday
      t.text :Sunday
      t.boolean :allowChangeHour
      t.timestamps
    end

  end

  def self.down
    drop_table :la_details
  end
end
