class CreateSystemValues < ActiveRecord::Migration[5.2]
  def change
    create_table :system_values do |t|
      t.string :name, unique: true
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :system_values
  end
end
