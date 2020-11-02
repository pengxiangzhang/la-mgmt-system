class CreateFormbuilders < ActiveRecord::Migration[5.2]
  def change
    create_table :formbuilders do |t|
      t.string :formname, unique: true
      t.text :formdata

      t.timestamps
    end
  end
end
