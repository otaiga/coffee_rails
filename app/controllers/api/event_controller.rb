#Event controller for api requests
class Api::EventController <  Api::BaseController

  def index
    @events = Event.hashed_response
    render :status=>200, :json=> @events
  end

end