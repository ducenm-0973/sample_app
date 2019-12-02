module ApplicationHelper
  def full_title page_title = ""
    base_title = t "helpers.application_helper.base_title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
