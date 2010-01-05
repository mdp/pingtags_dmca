class UserSessionsController < ApplicationController
  layout 'simple'
  before_filter :require_user, :only => [:destroy]
  before_filter :require_no_user, :only => [:new, :create]
  
  
  def new
  end
  
  # Redirect to LinkedIn for auth
  def linkedin
    create
  end
  
  def create
    session[:email] = params[:email]
    client = LinkedIn.client
    request_token = client.get_request_token(:oauth_callback => oauth_callback_url)
    session[:request_token]  = request_token.token
    session[:request_token_secret]  = request_token.secret
    redirect_to request_token.authorize_url
  end
  
  # Catch OAuth callbacks and create or logs in user
  def oauth_callback
    request_token = OAuth::RequestToken.new(LinkedIn.client, session[:request_token], session[:request_token_secret])
    access_token = request_token.get_access_token(:oauth_verifier => params["oauth_verifier"])
    @user = User.create_or_update_with_access_token(access_token, :email => session[:email])
    if @user.errors.empty?
      UserSession.create(@user, true)
      flash[:message] = "Logged in successfully as #{current_user.first_name} #{current_user.last_name}"
      redirect_to account_url
    else
      flash[:message] = "There was a problem logging you in"
      redirect_to signup_url
    end
  end
  
  def destroy
    if current_user
      current_user_session.destroy
      flash[:notice] = "Logout successful!"
    end
    redirect_back_or_default root_url
  end
  
end