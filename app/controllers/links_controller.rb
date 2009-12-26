class LinksController < ApplicationController
  
  def create
    if @click = Click.first(:conditions => ['scan_id = ? AND link_href = ?', params[:scan_id], params[:link_href]]) 
      @click.update_attribute(:created_at, Time.now)
    else 
      @click = Click.create(:link => params[:link], :link_href => params[:link_href], :scan_id => params[:scan_id])
    end
    redirect_to @click.link_href
  end
  
end
