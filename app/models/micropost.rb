class Micropost < ApplicationRecord
  belongs_to :user

  default_scope -> {order created_at: :desc}
  scope :follow_post, ->(user_ids){where(user_id: user_ids)}

  mount_uploader :picture, PictureUploader

  MICROPOST_PARAMS = %i(content picture).freeze
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_content_length}
  validate :picture_size

  delegate :name, to: :user, prefix: true

  private

  def picture_size
    return unless picture.size > Settings.picture_size.megabytes
    errors.add :picture, t(".picture.size")
  end
end
