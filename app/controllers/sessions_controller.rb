class SessionsController < ApplicationController
  def new
  end

  def create
    unless params[:session].blank?
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        # Вход и редирект на страницу работы
        sign_in user
        redirect_to work_url
      else
        # Ошибка при входе
        flash.now[:alert] = "Login failed. Invalid email/password combination. Repeat"
        render "new"
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
