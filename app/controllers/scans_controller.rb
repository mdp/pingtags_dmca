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
        scan.attributes = {:lat => params[:lat], :long => params[:long]}
        scan.save!
        render :text => 'OK', :status => 200
      else
        render :text => 'SECURITY FAIL!!! Stop, collaborate and listen.', :status => 403
      end
    else
      render :text => 'YOU FAIL!!!', :status => 406
    end
  end
  
  private
  
  def ensure_authorized
    if params[:id] && @scan = Scan.find(params[:id])
      render :text => 'NotAuthorized', :status => 403 unless current_user.id == @scan.user_id
    end
  end
  
end