class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update)
  before_action :load_user, except: %i(new index create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.activated.page(params[:page]).per Settings.per_page
  end

  def show
    redirect_to root_url unless @user.activated
    @microposts = @user.microposts.page(params[:page]).per Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("users_controller.check_mail")
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users_controller.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users_controller.deleted"
      redirect_to users_url
    else
      flash[:danger] = t "users_controller.delete_fail"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t "users_controller.not_found"
    redirect_to root_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
