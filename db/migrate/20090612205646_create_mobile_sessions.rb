class CreateMobileSessions < ActiveRecord::Migration
  def self.up
    create_table :mobile_sessions do |t|
      t.string :cookie
      t.string :user_agent
      t.timestamps
    end
  end

  def self.down
    drop_table :mobile_sessions
  end
end
