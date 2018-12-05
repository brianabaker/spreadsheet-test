class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to new_spreadsheet_import_url
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

end
