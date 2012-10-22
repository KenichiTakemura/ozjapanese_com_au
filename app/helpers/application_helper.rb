module ApplicationHelper
  
  def debug?
    OzjapaneseComAu::Application.config.is_debug
  end
  
end
