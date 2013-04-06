#Main controller (admin root view)
class MainsController < ApplicationController
  before_filter :authenticate_user!

  def index
    prize_record = Prize.first
      @prize_status = "disabled"
      @prize = nil
    if prize_record
      @prize_status = prize_record.prize_stat
      @prize = prize_record.prize
    end
  end

  def toggle_prize_status
    prize_record = Prize.first
    if prize_record
      toggle_stat(prize_record)
    else
      Prize.create(
        prize_stat: "enabled",
        prize: nil
        )
    end
    redirect_to root_path
  end

  def update_prize
    prize = params[:prize_name].to_s
    prize_record = Prize.first
    if prize_record
      prize_record.update_attributes(prize: prize)
    else
      Prize.create(
        prize_stat: "disabled",
        prize: prize
        )
    end
    redirect_to root_path
  end

private

  def toggle_stat(prize_record)
    case prize_record.prize_stat
    when "enabled"
      prize_record.update_attributes(prize_stat: "disabled")
    when "disabled"
      prize_record.update_attributes(prize_stat: "enabled")
    else
      prize_record.update_attributes(prize_stat: "enabled")
    end
  end

end
