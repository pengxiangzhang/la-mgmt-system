class CreateLapromtAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :lapromt_announcements do |t|
      t.string :name
      t.string :text
      t.string :color_1
      t.string :color_2
      t.string :color_3
      t.timestamps
    end
  end
end
