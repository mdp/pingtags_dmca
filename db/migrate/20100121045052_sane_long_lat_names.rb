class SaneLongLatNames < ActiveRecord::Migration
  def self.up
    rename_column :scans, :long, :longitude
    rename_column :scans, :lat, :latitude
  end

  def self.down
    rename_column :scans, :latitude, :lat
    rename_column :scans, :longitude, :long
  end
end
