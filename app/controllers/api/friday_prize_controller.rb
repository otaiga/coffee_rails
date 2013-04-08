# Friday Prize controller for api requests
class Api::FridayPrizeController <  Api::BaseController
  before_filter :check_status, :prize_available? :only => [:create]

  def index
    prize_record = Prize.first
    if prize_record
      prize_status = prize_record.prize_stat
    else
      prize_status = "disabled"
    end
    response = {prize_status: prize_status}
    render :status=>200, :json=> response
  end

  def create
    result = get_prize
    case result
    when "already taken"
      message = "Sorry prize has been won today"
      @response = {taken_message: message}
    when false
      message = "Sorry better luck next time"
      @response = {fail_message: message}
    else
      update_prize_status
      @response = {prize: result}
    end
    render :status=>200, :json=> @response
  end

private

  def check_status
    prize_record = Prize.first
    if prize_record
      prize_status = prize_record.prize_stat
      prize = prize_record.prize
      if prize_status == "enabled" and prize
        return true
      end
    else
      render :status => 406, :json=>{
        :errors => ["Prize Status not enabled"]
      }
    end
  end

  def prize_available?
    prize = Prize.first.prize if Prize.first
    if prize == "already taken"
      message = "Sorry prize has been won today"
      response = {taken_message: message}
      render :status=>200, :json=> response
    else
      return true
    end
  end

  def get_prize
    #Array of 99 empty entries and one with the prize.
    prize_record = Prize.first
    if prize_record
      prize = prize_record.prize
      unless prize.nil?
        chance_array.push(prize).shuffle.sample
      end
    else
      return false
    end
  end

  def update_prize_status
    Prize.first.update_attributes(
      prize_stat: "disabled",
      prize: "already taken"
      )
  end

  def chance_array(a_count = 29)
    #Setting to 100 in 1
    chance_array = Array.new( a_count, false )
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