class SessionsController < ApplicationController
  def new
    @user = nil
  end

  def create
    user = User.find_by_credentials(username, password)

    if user
      login!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  def username
    params[:user][:username]
  end

  def password
    params[:user][:password]
  end
end
