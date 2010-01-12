# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user_session, :current_user, :title

  private
    def self.title(new_title = nil)
      if new_title
        @title = new_title
      else
        @title
      end
    end
    
    def title
      @title || self.class.title
    end
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def redirect_back_or_default(default)  
      redirect_to(session[:return_to] || default)  
      session[:return_to] = nil  
    end
    
    def require_no_user
      if current_user
        redirect_to account_url
      end
    end
    
    def require_user
      unless current_user
        redirect_to login_url
      end
    end

end
