# Friday Prize controller for api requests
# Allows only to be called on friday's
# Need's to capture email and unique (model check) -  Prize?
class Api::FridayPrizeController <  Api::BaseController
  before_filter :checks_passed?, :only => [:create]

  #check to see if friday prize is enabled.
  def index
    #TODO model settings? - to check for prize enabled?
    stub_response = {prize_status: "enabled"}
    render :status=>200, :json=> stub_response
  end

  def create
    if get_prize
      @response = {prize: "1 Small Coffee"}
    else
      message = "Sorry better luck next time"
      @response = {fail_message: message}
    end
    render :status=>200, :json=> @response
  end

private

  def get_prize
    #TODO - retieve prize from model?
    #Array of 99 empty entries and one with the prize.
    stub_prize = "1 Small Coffee"
    chance_array.push(stub_prize).shuffle.sample
  end

  def chance_array(a_count = 99)
    #Setting to 100 in 1
    chance_array = Array.new( a_count, false )
  end

  def checks_passed?
    if check_email? && check_friday?
      return true
    else
      render :status => 406, :json=>{
        :errors => ["Email must be present and should be Friday"]
      }
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