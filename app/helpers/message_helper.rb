module MessageHelper
  def form_error_messages!(resource)
    if resource.errors.empty?
      return ""
    end

    messages = resource.errors.full_messages.map { |msg|
      show_alert(msg)
    }.join

    messages.gsub!('Email',I18n.t(:email))
    messages.gsub!('User name',I18n.t(:name))
    messages.gsub!('Phone',I18n.t(:phone))
    messages.gsub!('Body',I18n.t(:content))
    messages.gsub!('Subject',I18n.t(:subject))
    messages.gsub!('Content body',I18n.t(:content))

    html = <<-HTML
      #{messages}
    HTML

    html.html_safe
  end
end