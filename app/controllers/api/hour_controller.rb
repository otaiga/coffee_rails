#Food controller for api requests
class Api::HourController <  Api::BaseController

  def index
    @opening_times = OpeningTime.hashed_response
    render :status=>200, :json=> @opening_times
  end

end