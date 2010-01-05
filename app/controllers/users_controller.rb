class UsersController < ApplicationController
  before_filter :require_no_user, :only => :create
  
  def show
    @user = User.find_by_crypt_id(params[:crypt_id])
    if @user
      @scan = log_scan(@user)
    end
    render :layout => 'iphone'
  end
  
  def create
    render :layout => 'simple'
  end
  
  # AJAX ping or form submit
  def ping
  end
  
  private
  
  def log_scan(user)
    Scan.first(:conditions => ['user_id = ? AND device_id = ?', user.id, tracked_device.id]) || 
      Scan.create(:user_id => user.id, :device_id => tracked_device.id)
  end
  
  def tracked_device
    if session[:device_id] && device = Device.first(session[:device_id])
      device
    else
      device = Device.create(:user_agent => request.user_agent)
      session[:device_id] = device.id
      device
    end
  end

end