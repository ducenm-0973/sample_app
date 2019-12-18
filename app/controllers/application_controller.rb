class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users_controller.please"
    redirect_to login_url
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user

    flash[:danger] = t "users_controller.not_found"
    redirect_to root_url
  end
end
