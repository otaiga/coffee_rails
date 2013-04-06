#Main controller (admin root view)
class MainsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @prize_status = REDIS.get("coffee_prize_stat")
    @prize = REDIS.get("coffee_prize")
  end

  def toggle_prize_status
    prize_status = REDIS.get("coffee_prize_stat")
    case prize_status
    when "enabled"
      REDIS.set("coffee_prize_stat", "disabled")
    when "disabled"
      REDIS.set("coffee_prize_stat", "enabled")
    else
      REDIS.set("coffee_prize_stat", "disabled")
    end
    redirect_to root_path
  end

  def update_prize
    prize = params[:prize_name].to_s
    if prize
      REDIS.set("coffee_prize", prize)
    end
    redirect_to root_path
  end

end
