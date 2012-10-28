class OzInfoLivingQnasController < OzPostsController

  def filter
    @heading = :ozj_h9
  end


  def create
    create_post(OzInfoLivingQna, :oz_info_living_qna)
  end
end
