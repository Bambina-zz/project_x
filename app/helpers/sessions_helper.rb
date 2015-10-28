module SessionsHelper
  def login(user)
    session[:user_id] = user.id
    self.current_user = user
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
