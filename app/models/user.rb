class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEX = Settings.mail_regex

  before_save :email_downcase

  validates :name, presence: true, length: {maximum: Settings.name_maxlength}
  validates :email, presence: true, length: {maximum: Settings.email_maxlength},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.password_maxlength}

  private

  def email_downcase
    email.downcase!
  end
end
