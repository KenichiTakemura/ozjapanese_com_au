class OzEstateShareRentsController < OzPostsController

  def filter
    @heading = :ozj_h5
  end


  def create
    create_post(OzEstateShareRent, :oz_estate_share_rent)
  end
end
