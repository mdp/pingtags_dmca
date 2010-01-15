class Admin::UsersController < AdminController
  
  def index
    @users = User.all.paginate :page => params[:page]
  end
  
  def show
    @user = User.find_by_id(params[:id])
    @scans = @user.scans.paginate :page => params[:page]
    render 'accounts/show'
  end
  
end