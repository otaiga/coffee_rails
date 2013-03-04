#Food controller for api requests
class Api::DrinkController <  Api::BaseController

  def index
    @categories = DrinkMenu.hashed_response
    render :status=>200, :json=> @categories
  end

end