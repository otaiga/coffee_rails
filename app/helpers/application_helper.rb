# encoding: utf-8

#Had to add the above encoding option in order to use
#multibyte char ASCII (£)

module ApplicationHelper

  def f_price(value)
    "£" + "%.2f" % value.to_f
  end

end
