class LinksController < ApplicationController
  
  def redirect
    if params[:id]
      link = self.find_by_id(params[:id])
      Click.create(:link_id => params[:id], :scan_id => params[:sid])
    end
    redirect_to link.destination_url
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
end
