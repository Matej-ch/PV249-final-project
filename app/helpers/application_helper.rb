module ApplicationHelper

  def flash_class(type)
    case type
      when 'alert'
        "alert-danger"
      when 'notice'
        "alert-info"
      when 'error'
        "alert-danger"
      else
        ""
    end
  end

  def can_display_status?(status)
    signed_in? && !current_user.has_blocked?(status.user) || !signed_in?
  end

  def show_file(status)
    html =''
    if status.document && status.document.attachment?
      html << content_tag(:span, 'File', class: 'label label-info')
      html << link_to( status.document.attachment_file_name, status.document.attachment.url)
      return html.html_safe
    end
  end

  def avatar_profile_link(user, image_opt={}, html_opt={})
    avatar_url = user.avatar? ? user.avatar.url : user.gravatar_url
    link_to(image_tag(avatar_url, image_opt), profile_path(user.nick_name),html_opt)
  end
end
