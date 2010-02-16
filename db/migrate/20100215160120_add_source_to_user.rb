class AddSourceToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :source, :string, :default => 'signup'
    User.all.each do |u|
      u.source = "signup"
      u.save
    end
  end

  def self.down
    remove_column :users, :source
  end
end
