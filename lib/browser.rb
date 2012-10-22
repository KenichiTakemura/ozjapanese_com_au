module Browser
  NOT_DETECTED = 0
  Safari = 1
  Chrome = 2
  Firefox = 3
  Opera = 4
  MSIE = 5

  def self.browser_detection(request, agent=nil)
    return if !request.present? && !agent.present?
    agent = agent.presence || request.env['HTTP_USER_AGENT']
    browser_compatible = NOT_DETECTED
    if agent =~ /Safari/
      unless agent =~ /Chrome/
        version = agent.split('Version/')[1].split(' ').first.split('.').first
        browser_compatible = Safari
      else
        version = agent.split('Chrome/')[1].split(' ').first.split('.').first
        browser_compatible = Chrome
      end
    elsif agent =~ /Firefox/
      version = agent.split('Firefox/')[1].split('.').first
      browser_compatible = Firefox
    elsif agent =~ /Opera/
      version = agent.split('Version/')[1].split('.').first
      browser_compatible = Opera
    elsif agent =~ /MSIE/
      version = agent.split('MSIE')[1].split(' ').first
      browser_compatible = MSIE
    end
    browser_compatible
  end
end