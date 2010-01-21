class ScansController < ApplicationController
  before_filter :require_user, :except => [:update_location]
  before_filter :ensure_authorized, :only => [:show]
  
  def show
    render
  end
  
  def update_location
    if params[:lat] && params[:long] && params[:id] && params[:scan_hash]
      scan = Scan.find(params[:id])
      if scan.hmac == params[:scan_hash]        
        scan.attributes = {:latitude => params[:lat], :longitude => params[:long]}
        scan.save!
        render :text => 'OK', :status => 200
      else
        render :text => 'You have failed to send a valid HMAC', :status => 403
      end
    else
      render :text => 'Not enough params', :status => 406
    end
  end
  
  private
  
  def ensure_authorized
    if params[:id] && @scan = Scan.find(params[:id])
      unless current_user.id == @scan.user_id || current_user.admin?
        render :text => 'NotAuthorized', :status => 403
      end
    end
  end
  
end