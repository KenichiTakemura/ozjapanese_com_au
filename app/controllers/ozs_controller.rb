class OzsController < OzController
  
  before_filter :_before_, :except => [:carousel_viewed]

  def _before_
    raise "Bad Request" if params[:v].nil?
    logger.debug("v: #{params[:v]} d: #{params[:d]}")
    @board = Ozlink.param_v(params[:v])
    redirect_to root_path and return if !@board.present?
    @@board_id = params[:d].present? ? Ozlink.param_to_i(params[:d]) : nil
    logger.debug("@board: #{@board} board_id: #{@@board_id}")
    @heading = @board.to_sym
  end
  
  def index
    model = _model(@heading)
    raise "Bad Board Request" if model.nil?
    @board_lists = model.search(PostDef::POST_DISPLAY_NUMBER)
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def write
    if !current_flyer
      session["flyer_return_to"] = request.original_url
      redirect_to root_path
    end
    @post = _model(@heading).new
    @post.write_at = Common.current_time.to_i
    @post.build_content
    @post.valid_until = PostDef.post_expiry
    @post
  end
  
  def view
    @post = _model(@heading).find(@@board_id)
    @post.viewed
    @post
  end
  
  def carousel_viewed
    @heading = params[:p].split("-")[0].to_sym
    @@board_id = params[:p].split("-")[1]
    logger.debug("carousel_viewed #{@heading} with #{@@board_id}")
    if !@heading.present? || !@@board_id.present?
      raise "Bad Request for carousel_viewed"
    end
    view
  end
  
  def feed_view
    feed_type = params[:f].present? ? Ozlink.param_to_s(params[:f]) : nil
    raise "Bad Feed View Request" if !feed_type.present?
    model_name = OzjapaneseStyle.heading_model_name(@heading)
    case feed_type
     when "recent_week"
       feed = TopFeedList.recent_feed(model_name, 2)
     when "today"
       feed = TopFeedList.feed_for_date(model_name, 0)
     when "yesterday"
       feed = TopFeedList.feed_for_date(model_name, 1)
     else
       raise "Bad feed type #{feed_type}"
     end
    @posts = feed.collect{ |f| f.feeded_to }
    logger.debug("feed_view: #{@posts.size}")
  end

end
