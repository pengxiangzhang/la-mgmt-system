class CreateFormBuilders < ActiveRecord::Migration[5.2]
  def change
    create_table :form_builders do |t|
      t.string :formname
      t.text :formdata

      t.timestamps
    end
  end
end
