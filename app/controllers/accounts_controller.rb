class AccountsController < ApplicationController
  before_filter :require_user
  before_filter :ensure_email, :except => [:update_contact, :update]
  
  def show
    @user = current_user
  end
  
  def update
    if params[:user]
      current_user.update_attributes(params[:user])
      if current_user.save
        flash[:message] = "Updated!"
        redirect_to account_url
      else
        render "update_contact"
      end
    end
  end
  
  def update_contact
    @user = current_user
    render :layout => 'simple'
  end
  
  private
  
  def ensure_email
    # unless a user has an email address, force them to give one
    # we also check to see if it's been stuck in a session, such as
    # on signup
    unless current_user.email
      if session[:email]
        current_user.email = session[:email]
        unless current_user.save
          redirect_to update_contact_account_path
        end
      else
        redirect_to update_contact_account_path
      end
    end
  end
  
end