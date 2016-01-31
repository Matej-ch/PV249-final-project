class Document < ActiveRecord::Base
  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/

  attr_accessor :remove_attachment

  before_save :attachment_remove

  def attachment_remove
    if remove_attachment == '1' && !attachment.dirty?
      self.attachment = nil
    end
  end

end
