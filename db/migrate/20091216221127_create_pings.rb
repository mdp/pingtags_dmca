class CreatePings < ActiveRecord::Migration
  def self.up
    create_table :pings do |t|
      t.integer :user_id
      t.integer :email
      t.comment :text
      t.integer :pinged_by

      t.timestamps
    end
  end

  def self.down
    drop_table :pings
  end
end
