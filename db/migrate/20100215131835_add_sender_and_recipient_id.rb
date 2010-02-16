class AddSenderAndRecipientId < ActiveRecord::Migration
  def self.up
    remove_column :pings, :user_id
    add_column :pings, :sender_id, :integer
    add_column :pings, :recipient_id, :integer
  end

  def self.down
    remove_column :pings, :recipient_id
    remove_column :pings, :sender_id
    add_column :pings, :user_id, :integer
  end
end
