module Ozlink
  
  def self.me
    "http://www.ozjapanese.com.au"
  end
  
  def self.ozlink(controller, action, options=nil)
    link = nil
    if action.present?
      link = %Q|/ozs/#{action}?v=| + base(controller)
      if options.present?
        options.each do |k,v|
          link += "&#{k.to_s}=" + param_enc(v)
        end
      end
    else
      link = %Q|/ozs?v=| + base(controller)
    end
    link
  end

  def self.heading_link(heading, action, options=nil)
    raise "Bad Request with [#{heading}]" if !OzjapaneseStyle.heading_controller(heading).present?
    ozlink(OzjapaneseStyle.heading_controller(heading),action, options)
  end

  def self.param_v(v)
    _d = dec(v)
    return nil if !_d
    p = _d.split(SP)[1]
    p
  end

  def self.param_to_s(p)
    d = dec(p)
    d
  end

  def self.param_to_i(p)
    _d = dec(p)
    return nil if !_d
    d = _d.to_i
    d
  end

  private

  def self.param_enc(e)
    enc(e).chop if e.present?
  end

  def self.base(okpage)
    raise "Bad Request okpage nil" if okpage.nil?
    enc("#{Common.current_time.to_i}#{SP}#{okpage}").chop
  end
  
  def self.dec(d)
    begin
      Common.decrypt_data(d)
    rescue
    false
    end
  end

  def self.enc(d)
    Common.encrypt_data(d.to_s)
  end
  
  SP = "+"

end