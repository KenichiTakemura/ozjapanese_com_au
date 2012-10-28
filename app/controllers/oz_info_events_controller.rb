class OzInfoEventsController < OzPostsController

  def filter
    @heading = :ozj_h6
  end


  def create
    create_post(OzInfoEvent, :oz_info_event)
  end
end
