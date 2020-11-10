class CreateRackCasSessions < ActiveRecord::Migration[4.2]
  def self.up
    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.string :cas_ticket, :limit => 1000
      t.text :data
      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
