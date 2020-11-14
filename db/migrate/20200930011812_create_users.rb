class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :eduPersonPrincipalName, unique: true

      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
