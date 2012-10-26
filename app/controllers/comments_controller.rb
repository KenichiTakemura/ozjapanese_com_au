class CommentsController < OzController
  
  before_filter :authenticate_user!, :only => [:create, :reply]
  
  def initialize
    super
    @lock = Mutex.new
  end

  def create
    comment = Comment.new(params[:comment])
    logger.debug("Commented_id #{params[:commented_id]}")
    logger.debug("Commented_type #{params[:commented_type]}")
    @okpage = params[:commented_type].to_sym
    model = MODELS[@okpage]
    @post = model.find(params[:commented_id])
    # File the last number of comment for post
    ActiveRecord::Base.transaction do
      if comment.save
        comment.subscribe_to(@post, current_user)
        if @post.comment_email
          if !@post.posted_by.email.eql?(comment.commented_by.email)
            CommentMailer.send_comment_to_author(@okpage, @post, comment).deliver
          else
            Rails.logger.info("Self comment not send email. By #{comment.commented_by.email}")
          end
        end
        @comment = Comment.new
        respond_to do |format|
          format.html { redirect_to "#{Okboard.okboard_link_with_id(@okpage, @post.id)}" }
          format.json { render :json => @post, :status => :created }
        end
      else
        flash[:warning] = I18n.t("failed_to_create")
        @post.errors.full_messages.each do |msg|
          logger.warn("@post.errors: #{msg}")
        end
        respond_to do |format|
          format.html { render :template => "okboards/view" }
          format.json { render :json => @post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  def post_comment
    @board = Ozlink.param_v(params[:v])
    raise "Bad Request" if !@board.present?
    @@board_id = Ozlink.param_to_i(params[:d])
    raise "Bad Request" if !@@board_id.present?
    @heading = @board.to_sym
    comment = Comment.new(:body => params[:m])
    @post = _model(@heading).find(@@board_id)
    ActiveRecord::Base.transaction do
      if comment.save
        comment.subscribe_to(@post, current_flyer)
      end
    end
  end
  
  # Redirect to sign in
  def new
    @okpage = params[:category].to_sym
    model = MODELS[@okpage]
    @post = model.find(params[:id])
    if !current_user
      session["flyer_return_to"] = Okboard.okboard_link_with_id_write_comment(@okpage, @post.id)
      redirect_to user_sign_in_path
    else
    end      
  end

  # Redirect to sign in
  def reply
    @comment = Comment.find(params[:id])
  end

  # Ajax
  def likes
    @lock.synchronize {
      ActiveRecord::Base.transaction do
        Comment.find(params[:id]).like
      end
    }
    @comment = Comment.find(params[:id])
  end

  def dislikes
    @lock.synchronize {
      ActiveRecord::Base.transaction do
        Comment.find(params[:id]).dislike
      end
    }
    @comment = Comment.find(params[:id])
  end

  def abuses
    @lock.synchronize {
      ActiveRecord::Base.transaction do
        Comment.find(params[:id]).report_abuse
      end
    }
    @comment = Comment.find(params[:id])
  end
  
  def post_for
    @board = Okboard.param_v(params[:v])
    post_id = params[:d].present? ? Okboard.param_to_i(params[:d]) : nil
    @okpage = @board.to_sym
    @post = MODELS[@okpage].find(post_id)
  end

end
