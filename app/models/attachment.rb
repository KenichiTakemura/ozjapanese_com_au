class Attachment < Attachable
  
  has_attached_file :avatar, :styles => {},
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ':rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename'
   
  def to_s
    super.to_s
  end

  MAX_ATTACHMENT_SIZE = 5.megabytes

  # https://github.com/thoughtbot/paperclip
  validates_attachment_size :avatar, :less_than => MAX_ATTACHMENT_SIZE
  validates :avatar_content_type, :thumbnailable => true
  validates_presence_of :write_at

  after_initialize :set_default

  def set_default
    self.thumb_size ||= ""
    self.medium_size ||= ""
  end
  
  def url
    self.avatar.url(:original)
  end
  
  def filename
    self.avatar_file_name
  end
  
end
