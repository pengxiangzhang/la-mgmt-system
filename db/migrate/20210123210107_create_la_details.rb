class CreateLaDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :la_details do |t|
      t.belongs_to :user_detail, :foreign_key => "user_detail_id"
      t.string :course, array: true
      t.string :Monday
      t.string :Tuesday
      t.string :Wednesday
      t.string :Thursday
      t.string :Friday
      t.string :Saturday
      t.string :Sunday
      t.boolean :allowChangeHour, default: true
      t.string :announcement, default: 'No announcement found'
      t.string :location, default: 'No location found'
      t.timestamps
    end

  end

  def self.down
    drop_table :la_details
  end
end
