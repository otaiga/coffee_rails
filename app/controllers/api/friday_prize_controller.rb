# Friday Prize controller for api requests
# Allows only to be called on friday's
# Need's to capture email and unique (model check) -  Prize?
class Api::FridayPrizeController <  Api::BaseController

  def create

  end

private

  def get_prize
    #TODO - get a prize using array - 100 in 1 chance?
    #Array of 99 empty entries and one with the prize.
  end

end