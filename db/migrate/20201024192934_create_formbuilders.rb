class CreateFormbuilders < ActiveRecord::Migration[5.2]
  def change
    create_table :formbuilders do |t|
      t.string :formname
      t.string :formdata, :limit =>2000

      t.timestamps
    end
  end
end
