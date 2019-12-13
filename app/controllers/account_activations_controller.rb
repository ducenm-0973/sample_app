class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attributes activated: true, activated_at: Time.zone.now
      user.activate
      log_in user
      flash[:success] = t("account_activations_controller.activated")
      redirect_to user
    else
      flash[:danger] = t("account_activations_controller.invalid_activation_link")
      redirect_to root_url
    end
  end
end
