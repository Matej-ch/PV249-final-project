module AlbumsHelper

  def album_thumbnail(album)
    if album.pictures.count > 0
      image_tag(album.pictures.first.asset.url(:small))
    else
      image_tag('logo.jpg', width: '100px', height: '100px')
    end
  end

  def can_edit_album?(album)
    signed_in? && current_user == album.user
  end
end
