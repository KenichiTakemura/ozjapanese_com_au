class ContactMailer < ActionMailer::Base
  default :from => "#{I18n.t("contact.mail_from")} <do_not_reply@ozjapanese.com.au>"
  @@admin_email = OzjapaneseComAu::Application.config.admin_email
  @@admin_email_locale = OzjapaneseComAu::Application.config.admin_email_locale
  
  def send_new_post_to_admin(heading, post)
    to = @@admin_email
    I18n.with_locale(@@admin_email_locale) do
      subject = "#{I18n.t("mail.admin.subject")}" + " [#{I18n.t("mail.admin.new_post")}] " + OzjapaneseStyle.heading_name(heading) + " ID: " + post.id.to_s
      logger.info("email is besing sent to #{to}")
      @post = post
      @heading = heading
      mail(:to => to,
         :subject => subject)
    end
  end
  
  def send_contact_to_admin(contact)
    to = @@admin_email
    I18n.with_locale(@@admin_email_locale) do
      subject = "#{I18n.t("mail.admin.subject")}"
      @subject = "[#{contact.title(contact.contact_type)}]"
      subject += @subject
      logger.info("email is besing sent to #{to}")
      @contact = contact
      mail(:to => to,
         :subject => subject)
   end
  end
  
  def send_signup_to_admin(flyer)
    to = @@admin_email
    I18n.with_locale(@@admin_email_locale) do
      subject = "#{I18n.t("mail.admin.subject")}"
      @subject = "[#{I18n.t("mail.contact.new_flyer_joined", :from => flyer.flyer_name, :provider => flyer.provider)}]"
      subject += @subject
      logger.info("email is besing sent to #{to}")
      @flyer = flyer
      mail(:to => to,
         :subject => subject)
    end
  end

  def send_contact_to_flyer(contact)
    to = contact.email
    if OzjapaneseComAu::Application.config.is_debug
      to = @@admin_email
    end
    logger.info("email is besing sent to #{to}")
    subject = "#{I18n.t("contact.mail_flyer_subject")} "
    @subject = "[#{contact.title(contact.contact_type)}]"
    subject += @subject
    subject += t("contact.confirmation_email")
    @contact = contact
    mail(:to => to,
         :subject => subject)
  end
  
  def send_signup_to_flyer(flyer)
    to = flyer.email
    if OzjapaneseComAu::Application.config.is_debug
      to = @@admin_email
    end
    logger.info("email is besing sent to #{to}")
    subject = "#{I18n.t("contact.mail_flyer_subject")} "
    subject += t("contact.signup_confirmation_email")
    @flyer = flyer
    mail(:to => to,
         :subject => subject)
  end

end
