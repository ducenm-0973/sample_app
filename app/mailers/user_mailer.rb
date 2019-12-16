class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailers.user_mailers.user_mailer")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mailers.user_mailers.password_reset")
  end
end
