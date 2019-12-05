class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEX = Settings.mail_regex
  USER_PARAMS = %i(name email password password_confirmation).freeze

  before_save :email_downcase

  validates :name, presence: true, length: {maximum: Settings.name_maxlength}
  validates :email, presence: true, length: {maximum: Settings.email_maxlength},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.password_minimumlength}

  private

  def email_downcase
    email.downcase!
  end
end
