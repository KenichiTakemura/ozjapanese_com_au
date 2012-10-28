class OzInfoLivingSmartsController < OzPostsController

  def filter
    @heading = :ozj_h8
  end


  def create
    create_post(OzInfoLivingSmart, :oz_info_living_smart)
  end
end
