class UsersController < ApplicationController
  
  def show
    @user = User.find_by_crypt_id(params[:crypt_id])
    render :layout => 'iphone'
  end
  
  def ping
    @pingee = User.find_by_crypt_id(params[:crypt_id])
    @pinger = User.create(params[:user])
    @ping = Ping.create(:pinger => @pinger, :pingee => @pingee)
    render :layout => 'iphone'
  end
  
  def signup
    @user = User.create(params[:user])
  end

end