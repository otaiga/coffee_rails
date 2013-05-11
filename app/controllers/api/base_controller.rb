#Base Controller for all json requests
#Checks for json requests
class Api::BaseController < ApplicationController
  before_filter :check_json, :check_api

  def check_json
    if request.format != :json
      render :status => 406, :json=>{
        :errors => ["Sorry the request must be in json"]
      }
      return
    end
  end

  def check_api
    if request.env['HTTP_X_API_TOKEN']
      token = request.env['HTTP_X_API_TOKEN']
      check_token(token)
    else
      render :status=>401, :json=>{:errors => ["HTTP Token: Access denied."]}
    end
  end

  def check_token(token)
    return unless token
    if token == Rails.application.config.api_token
      return true
    else
      render :status=>401, :json=>{:errors => ["HTTP Token: Access denied."]}
    end
  end

end