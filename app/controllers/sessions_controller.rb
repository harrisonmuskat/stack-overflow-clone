class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    if @user
      session[:user_id] = @user.id
      redirect_to questions_path
    else
      redirect_to questions_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to questions_path, :notice => "Signed out!"
  end

end
