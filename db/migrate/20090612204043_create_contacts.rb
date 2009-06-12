class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :phone_office
      t.string :phone_mobile
      t.string :phone_fax
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
