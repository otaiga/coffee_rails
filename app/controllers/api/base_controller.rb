#Base Controller for all json requests
#Checks for json requests
class Api::BaseController < ApplicationController
  before_filter :check_json

  def check_json
    if request.format != :json
      render :status => 406, :json=>{
        :errors => ["Sorry the request must be in json"]
      }
      return
    end
  end

end
