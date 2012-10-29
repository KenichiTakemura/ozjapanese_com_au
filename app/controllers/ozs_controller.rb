class OzsController < OzController
  
  before_filter :_before_, :except => [:carousel_viewed]
  before_filter :authenticate_flyer!, :only => [:write]

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
    newer
  end
  
  def older
    collect_posts :older
    breadcrumb :older, @heading
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def newer
    collect_posts :newer
    breadcrumb :newer, @heading
    respond_to do |format|
      format.html # index.html.erb
    end 
  end
  
  def write
    @post = _model(@heading).new
    @post.write_at = Common.current_time.to_i
    @post.build_content
    @post.valid_until = PostDef.post_expiry
    breadcrumb :write, @heading
    @post
  end
  
  # non-Ajax Request
  def link_view
    viewed
    breadcrumb :link_view, @post
    respond_to do |format|
      format.html # link_view.html.erb
    end 
  end
  
  # Ajax
  def viewed
    @post = _model(@heading).find(@@board_id)
    @post.viewed
    @comment = Comment.new
    @comment.commented_id = @post.id
    @comment.commented_type = @heading
    @comments = Comment.comment_for(@post.id).limit(PostDef::NUMBER_OF_COMMENT)
    @post
  end
  
  def carousel_viewed
    @heading = params[:p].split("-")[0].to_sym
    @@board_id = params[:p].split("-")[1]
    logger.debug("carousel_viewed #{@heading} with #{@@board_id}")
    if !@heading.present? || !@@board_id.present?
      raise "Bad Request for carousel_viewed"
    end
    viewed
  end
  
  def feed_view
    feed_type = params[:f].present? ? Ozlink.param_to_s(params[:f]) : nil
    logger.debug("feed_view feed_type: #{feed_type}")
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
    if feed.present?
      @comment = Comment.new
      @posts = feed.collect{ |f| f.feeded_to }
      logger.debug("feed_view: #{@posts.size}")
      @comment.commented_id = @posts.first.id
      @comment.commented_type = @heading
      @comments = Comment.comment_for(@posts.first.id).limit(PostDef::NUMBER_OF_COMMENT)
    end
    
  end
  
  def select_heading
    case @heading
    when :ozj_all
      @feed = Hash.new
      @feed_cnt = Hash.new
      OzjapaneseStyle.headings.each do |heading|
        model_name = OzjapaneseStyle.heading_model_name(heading)
        date_feed = Array.new
        0.upto(1) { |d|
          date_feed[d] = TopFeedList.feed_for_date(model_name, d).count
          logger.debug("date_feed[#{d}]: #{date_feed[d]}")
        }
        @feed[heading.to_sym] = date_feed
        @feed_cnt[heading.to_sym] = TopFeedList.recent_feed(model_name, 2).count
        logger.debug("@feed[#{heading}]: #{@feed[heading.to_sym]}")
        logger.debug("@feed_cnt[#{heading}]: #{@feed_cnt[heading.to_sym]}")
      end
    when :ozj_h1
      collect_posts :newer
    when :ozj_h2
      collect_posts :newer
    when :ozj_h3
      collect_posts :newer
    when :ozj_h4
      collect_posts :newer
    when :ozj_h5
      collect_posts :newer
    when :ozj_h6
      collect_posts :newer
    when :ozj_h8
      collect_posts :newer
    when :ozj_h9
      collect_posts :newer
    when :ozj_h7
    when :ozj_h11
    else
      raise "Bad Request #{@heading}"
    end
  end
  
  private
  
  def collect_posts(newer_or_older)
    model = _model(@heading)
    raise "Bad Board Request" if model.nil?
    if newer_or_older.eql? :newer
      @posts = model.search_newer_than(PostDef::POST_DISPLAY_NUMBER, PostDef::POST_OLDER)
    elsif newer_or_older.eql? :older
      @posts = model.search_older_than(PostDef::POST_DISPLAY_NUMBER, PostDef::POST_OLDER)
    end
    if @posts.present?
      @comment = Comment.new
      @comment.commented_id = @posts.first.id
      @comment.commented_type = @heading
      @comments = Comment.comment_for(@posts.first.id).limit(PostDef::NUMBER_OF_COMMENT)
    end
    logger.debug("@posts: #{@posts.size}")
    @posts
  end

end
