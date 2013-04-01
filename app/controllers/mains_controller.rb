#Main controller (admin root view)
class MainsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @prize_status = $redis.get("coffee_prize_stat")
    @prize = $redis.get("coffee_prize")
  end

  def toggle_prize_status
    prize_status = $redis.get("coffee_prize_stat")
    case prize_status
    when "enabled"
      $redis.set("coffee_prize_stat", "disabled")
    when "disabled"
      $redis.set("coffee_prize_stat", "enabled")
    else
      $redis.set("coffee_prize_stat", "disabled")
    end
    redirect_to root_path
  end

  def update_prize
    prize = params[:prize_name].to_s
    if prize
      $redis.set("coffee_prize", prize)
    end
    redirect_to root_path
  end

end
