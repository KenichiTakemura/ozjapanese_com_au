module PostDef
  
  POST_OLDER = 10

  POST_EXPIRY = 60
  
  POST_DISPLAY_NUMBER = 50
  
  NUMBER_OF_COMMENT = 5
  
  MAX_POST_COMMENT_LENGTH = 1000
  MAX_POST_CONTENT_LENGTH = 50000
  MAX_BUSINESS_PROFILE_CONTENT_LENGTH = 50000
  IMAGE_SOMETHING_LENGTH  = 65535

  MAX_CLIENT_IMAGE_SIZE = 5.megabytes
  MAX_BUSINESS_PROFILE_IMAGE_SIZE = 5.megabytes
  MAX_POST_IMAGE_SIZE = 5.megabytes
  MAX_POST_ATTACHMENT_SIZE = 5.megabytes
  
  # DB
  # 1 to 255 bytes: TINYTEXT
  # 256 to 65535 bytes: TEXT
  # 65536 to 16777215 bytes: MEDIUMTEXT
  # 16777216 to 4294967295 bytes: LONGTEXT
  DB_POST_COMMENT_LENGTH = 65535
  DB_ISSUE_TEXT_LENGTH = 65535
  DB_POST_CONTENT_LENGTH = 16777215
  DB_BUSINESS_PROFILE_CONTENT_LENGTH = 16777215
  
  DEFAULT_LOCALE = "ja"
  DEFAULT_CATEGORY = -1
  DEFAULT_ZINDEX = 0
  DEFAULT_ROLE = Role::R[:user_r] | Role::R[:user_w]

  ADMIN_POST_Z_INDEX = 10
  ADMIN_POST_NOTICE_Z_INDEX = 20
  ADMIN_POST_NOTICE = 0
  
  POST_STATUS_DRAFT = 0
  POST_STATUS_PUBLIC = 1
  POST_STATUS_HIDDEN = 2
  POST_STATUS_EXPIRED = 3
  POST_STATUS_COMPLETED = 4
  
  EMAIL_REGEXP = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  def self.post_expiry
    Common.current_time + POST_EXPIRY.days
  end
  
end