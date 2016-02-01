module PicturesHelper

  def can_edit_picture?(picture)
    signed_in? && current_user == picture.user
  end

  def paperclip_picture(form , paperclip_obj)
    if form.object.send("#{paperclip_obj}?")
      content_tag(:div, class: 'control-group') do
        content_tag(:label, "Curent #{paperclip_obj.to_s.titleize}", class: 'control-label')
        content_tag(:div, class: 'controls') do
          image_tag form.object.send(paperclip_obj).send(:url, :small)
        end
      end
    end
  end
end
