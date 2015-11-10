class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to errands_url
    else
      flash[:alert] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
