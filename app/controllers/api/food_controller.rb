class Api::FoodController <  Api::BaseController

  def index
    @categories = FoodMenu.hashed_response
    render :status=>200, :json=> @categories
  end

end