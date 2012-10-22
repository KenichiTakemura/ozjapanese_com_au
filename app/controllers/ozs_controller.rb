class OzsController < OzController
  
  
  before_filter :_before_, :except => []

  def _before_
    raise "Bad Request" if params[:v].nil?
    logger.debug("v: #{params[:v]} d: #{params[:d]}")
    @board = Ozlink.param_v(params[:v])
    redirect_to root_path and return if !@board.present?
    @@board_id = params[:d].present? ? Okboard.param_to_i(params[:d]) : nil
    logger.debug("@board: #{@board} board_id: #{@@board_id}")
    @heading = @board.to_sym
  end
  
  def index
    model = _model(@heading)
    raise "Bad Board Request" if model.nil?
    @board_lists = model.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def write
    if !current_flyer && !debug?
      session["flyer_return_to"] = request.original_url
      redirect_to root_path
    end
    @post = _model(@heading).new
    @post.write_at = Common.current_time.to_i
    @post.build_content
    @post.valid_until = PostDef.post_expiry
    @post
  end

end
