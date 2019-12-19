module UsersHelper
  def gravatar_for user, size: Settings.gravatar_size
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = Settings.gravatar_url + "#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def follow
    current_user.active_relationships.build
  end

  def unfollow
    current_user.active_relationships.find_by followed_id: @user.id
  end
end
