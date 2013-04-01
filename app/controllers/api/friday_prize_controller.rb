# Friday Prize controller for api requests
# Allows only to be called on friday's
# Need's to capture email and unique (model check) -  Prize?
class Api::FridayPrizeController <  Api::BaseController
  before_filter :checks_passed?, :only => [:create]
  before_filter :check_status, :only => [:create]

  def index
    prize_status = $redis.get("coffee_prize_stat")
    response = {prize_status: prize_status}
    render :status=>200, :json=> response
  end

  def create
    if !get_prize == "already taken" || !get_prize == false
      update_prize_status
      @response = {prize: get_prize}
    else
      message = "Sorry better luck next time"
      @response = {fail_message: message}
    end
    render :status=>200, :json=> @response
  end

private

  def check_status
    prize_status = $redis.get("coffee_prize_stat")
    if prize_status == "enabled"
      return true
    else
      render :status => 406, :json=>{
        :errors => ["Prize Status not enabled"]
      }
  end

  def get_prize
    #Array of 99 empty entries and one with the prize.
    prize = $redis.get("coffee_prize")
    unless prize.nil?
      chance_array.push(stub_prize).shuffle.sample
    end
  end

  def update_prize_status
    $redis.set("coffee_prize_stat", "disabled")
    $redis.set("coffee_prize", "already taken")
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