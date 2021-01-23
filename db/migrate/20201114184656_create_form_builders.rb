class CreateFormBuilders < ActiveRecord::Migration[5.2]
  def change
    create_table :form_builders do |t|
      t.string :formname,unique: true
      t.text :formdata

      t.timestamps
    end
  end

  def self.down
    drop_table :form_builders
  end
end
