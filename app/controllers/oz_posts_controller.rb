class OzPostsController < OzController

  before_filter :filter
  before_filter :authenticate_flyer!

  def filter
    
  end

  def create_post(_model, _param)
    @post = _model.new(params[_param])
    @post.valid_until = @post.valid_until.presence || PostDef.post_expiry
    logger.debug("post: #{@post}")
    @post.requested_by = request.env['HTTP_USER_AGENT']
    ActiveRecord::Base.transaction do
      if @post.save
        @post.set_user(current_flyer)
        ContactMailer.send_new_post_to_admin(@heading, @post).deliver
        flash[:notice] = I18n.t("successfully_created")
        respond_to do |format|
          format.html { redirect_to "#{Ozlink.heading_link(@heading, nil)}" }
          format.json { render :json => @post, :status => :created }
        end
      else
        flash[:warning] = I18n.t("failed_to_create")
        @post.errors.full_messages.each do |msg|
          logger.warn("@post.errors: #{msg}")
        end
        @post.build_content if @post.content.nil?
        respond_to do |format|
          format.html { render :template => "ozs/write" }
          format.json { render :json => @post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  protected


end