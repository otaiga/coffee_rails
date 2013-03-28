# Friday Prize controller for api requests
# Allows only to be called on friday's
# Need's to capture email and unique (model check) -  Prize?
class Api::FridayPrizeController <  Api::BaseController
  before_filter :checks_passed?

  def create
    get_prize
  end

private

  def get_prize
    #TODO - get a prize using array - 100 in 1 chance?
    #Array of 99 empty entries and one with the prize.
  end

  def checks_passed?
    if check_email? && check_friday?
      return true
    else
      return false
    end
  end

  def check_email?
    email = params[:email]
    if correct_format?(email)
      return true
    else
      return false
    end
  end

  def check_friday?
    day = Date.today.strftime("%A")
    if day == "Friday"
      return true
    else
      return false
    end
  end

  def correct_format?(email)
    return unless email
    check_string = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
    if email =~ check_string
      return true
    else
      return false
    end
  end

end