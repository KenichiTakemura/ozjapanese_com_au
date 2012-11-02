module UtilsHelper

  def link_to_with_icon(t,h,c,s,i,d)
    html = %Q|<a href="#{h}" class="#{c}" style="#{s}" id="#{d}"><i class="#{i}"></i>#{t}</a>|
    html.html_safe
  end
  
  def show_notice(message=nil)
    html = ""
    msg = message.presence || notice.presence || nil
    if msg
      html = %Q|<div class="alert alert-info alert-block fade in"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{msg}</h4></div>|
    end
    html.html_safe
  end
  
  def show_alert(message=nil)
    html = ""
    msg = message.presence || alert.presence || nil
    if msg  
      html = %Q|<div class="alert alert-block"><button type="button" class="close" data-dismiss="alert">×</button><h4>#{msg}</h4></div>|
    end
    html.html_safe
  end
  
  def _script_document_ready(script)
    html = %Q|<script type="text/javascript" charset="utf-8">$(document).ready(function() {#{script}});</script>|
    html.html_safe
  end

  def _script(script)
    %Q|<script type="text/javascript" charset="utf-8">#{script}</script>|.html_safe
  end
  
end