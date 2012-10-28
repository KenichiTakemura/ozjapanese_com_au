class OzEmployersController < OzPostsController

  def filter
    @heading = :ozj_h2
  end


  def create
    create_post(OzEmployer, :oz_employer)
  end
end
