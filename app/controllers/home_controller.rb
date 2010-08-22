# Here's our controller for the marketing pages.
class HomeController < ApplicationController

  def index
    @scans = Scan.find(:all, :limit => 20, :conditions => ["latitude IS NOT NULL AND longitude IS NOT NULL"])
  end

  def support

  end

  def about

  end

end
