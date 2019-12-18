class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]

    if @user
      current_user.follow @user
      flash[:success] = t ".success"
    else
      flash[:danger] = t "users_controller.not_found"
      redirect_to root_path
    end

    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed

    if @user
      current_user.unfollow @user
      flash[:success] = t ".success"
    else
      flash[:danger] = t "users_controller.not_found"
      redirect_to root_path
    end

    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
