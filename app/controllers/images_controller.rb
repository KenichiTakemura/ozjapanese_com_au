class ImagesController < OzController

  def create
    #  Parameters: {"remotipart_submitted"=>"true", "X-Http-Accept"=>"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01", "authenticity_token"=>"fYYDmz71XBiIpKpyYhZMeJJWF+4eurM8y318ezjcRps=", "utf8"=>"✓", "X-Requested-With"=>"IFrame", "image"=>{"something"=>"", "image"=>#<ActionDispatch::Http::UploadedFile:0x7f7137bb33e8 @content_type="text/plain", @original_filename="ozjapanese.txt", @tempfile=#<File:/tmp/RackMultipart20121104-10514-ytf10w-0>, @headers="Content-Disposition: form-data; name=\"image[image]\"; filename=\"ozjapanese.txt\"\r\nContent-Type: text/plain\r\n">}}
    logger.debug("create upload_image")
    param = params[:image]
    something = param[:something]
    write_at = param[:write_at]
    @image = Image.new(:avatar => param[:image])
    logger.info("something: #{something} write_at: #{write_at}")
    logger.info("image #{@image}")
    begin
      if @image.thumbnailable?
        logger.debug("image will be saved")
        @image.something = something
        @image.write_at = write_at
        if @image.save
          @image.attached_by(current_flyer)
          logger.debug("image saved. #{@image}")
          @images = Image.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_flyer, write_at)
          flash[:notice] = I18n.t("upload.success")
        else
          message = @image.errors.full_messages.map
          logger.error("image failed to save. #{message}")
          flash[:alert] = I18n.t("upload.failed_to_upload_with")
        end
      else
        logger.warn("image not thumbnailable #{@image.errors}")
        flash[:alert] = I18n.t("upload.has_invalid_content_type")
      end
    rescue Exception => e
      logger.error("something wrong e => #{$!}")
      flash[:alert] = I18n.t("upload.failed_to_upload")
    end
    respond_to do |format|
      format.js
    end
  end
  
end
