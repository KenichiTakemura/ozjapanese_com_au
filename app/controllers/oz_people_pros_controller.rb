class OzPeopleProsController < OzPostsController

  def filter
    @heading = :ozj_h7
  end


  def create
    create_post(OzPeoplePro, :oz_people_pro)
  end
end
