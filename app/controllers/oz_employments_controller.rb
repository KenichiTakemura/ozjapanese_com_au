class OzEmploymentsController < OzPostsController

  def filter
    @heading = :ozj_h1
  end


  def create
    create_post(OzEmployment, :oz_employment)
  end
end
