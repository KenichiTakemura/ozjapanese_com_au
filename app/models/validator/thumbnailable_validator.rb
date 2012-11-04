class ThumbnailableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.instance_of? Image
      unless record.thumbnailable?
        record.errors.add I18n.t("upload.image"), I18n.t("upload.has_invalid_content_type")
      end
    elsif record.instance_of? Attachment
      unless record.attachmentable?
        record.errors.add I18n.t("upload.image"), I18n.t("upload.has_invalid_content_type")
      end
    else
      raise "Instance error: #{record.name}" 
    end
  end
end
