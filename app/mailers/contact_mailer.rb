class ContactMailer < ActionMailer::Base
  default :from => "#{I18n.t("contact.mail_from")} <do_not_reply@ozjapanese.com.au>"
  
  def send_contact_to_admin(contact)
    to = Contact.admin_email
    subject = "#{I18n.t("contact.mail_admin_subject")}"
    @subject = "[#{contact.title(contact.contact_type)}]"
    subject += @subject
    logger.info("email is besing sent to #{to}")
    @contact = contact
    mail(:to => to,
         :subject => subject)
  end
  
  def send_signup_to_admin(flyer)
    to = Contact.admin_email
    subject = "#{I18n.t("contact.mail_admin_subject")}"
    @subject = "[#{I18n.t("contact.new_flyer_joined", :from => flyer.flyer_name)}]"
    subject += @subject
    logger.info("email is besing sent to #{to}")
    @flyer = flyer
    mail(:to => to,
         :subject => subject)
  end

  def send_contact_to_flyer(contact)
    to = contact.email
    if OzjapaneseComAu::Application.config.is_debug
      to = Contact.admin_email
    end
    logger.info("email is besing sent to #{to}")
    subject = "#{I18n.t("contact.mail_flyer_subject")}"
    @subject = "[#{contact.title(contact.contact_type)}]"
    subject += @subject
    subject += t("contact.confirmation_email")
    @contact = contact
    mail(:to => to,
         :subject => subject)
  end

end
