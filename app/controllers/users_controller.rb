class UsersController < ApplicationController
  before_filter :require_no_user, :only => :create
  title 'Users'
  
  def show
    @user = User.find_by_crypt_id(params[:crypt_id])
    if @user
      @scan = log_scan(@user)
    end
    render :layout => 'iphone'
  end
  
  def create
    @title = "Signup"
    render :layout => 'simple'
  end
  
  # AJAX ping or form submit
  def ping
  end
  
  private
  
  def log_scan(user)
    if @scan = Scan.first(
                    :conditions => ['user_id = ? AND device_id = ?', user.id, tracked_device.id], 
                    :order => "created_at DESC")
    else 
      @scan = Scan.create(:user_id => user.id, :device_id => tracked_device.id)
      @scan.ip_address = request.remote_ip
      @scan.save
    end
    @scan
  end
  
  def tracked_device
    if session[:device_id] && device = Device.find_by_id(session[:device_id])
      device
    else
      device = Device.create(:user_agent => request.user_agent)
      session[:device_id] = device.id
      device
    end
  end

end