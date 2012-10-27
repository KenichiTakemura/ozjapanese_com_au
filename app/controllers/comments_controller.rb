class CommentsController < OzController
  
  before_filter :before
  before_filter :authenticate_flyer!, :only => [:post_comment]
  
  def before
    @board = Ozlink.param_v(params[:v])
    raise "Bad Request" if !@board.present?
    @@board_id = Ozlink.param_to_i(params[:d])
    raise "Bad Request" if !@@board_id.present?
    @heading = @board.to_sym    
  end
    
  def post_comment
    comment = Comment.new(:body => params[:m])
    @post = _model(@heading).find(@@board_id)
    ActiveRecord::Base.transaction do
      if comment.save
        comment.subscribe_to(@post, current_flyer)
      end
    end
    @comments = Comment.comment_for(@post.id).limit(PostDef::NUMBER_OF_COMMENT)
  end
  
  def view_all
    @post = _model(@heading).find(@@board_id)
    @comments = Comment.comment_for(@@board_id)
  end

end
