class UserSessionsController < ApplicationController
  layout 'simple'
  
  def new
  end
  
  def linkedin
    client = LinkedIn.client
    request_token = client.get_request_token(:oauth_callback => oauth_callback_url)
    session[:request_token]  = request_token.token
    session[:request_token_secret]  = request_token.secret
    redirect_to request_token.authorize_url
  end
  
  def create
    request_token = OAuth::RequestToken.new(LinkedIn.client, session[:request_token], session[:request_token_secret])
    access_token = request_token.get_access_token(:oauth_verifier => params["oauth_verifier"])
    user = User.initialize_with_access_token(access_token)
    if user
      UserSession.create(user, true)
      flash[:message] = "Logged in as #{current_user.first_name} #{current_user.last_name}"
      redirect_to account_path
    else
      flash[:message] = 'You must authorize PingTags to use your LinkedIn account'
      render :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end