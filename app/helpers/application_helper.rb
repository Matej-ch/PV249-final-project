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
end
