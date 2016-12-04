class UserApiController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :authenticate
  around_filter :reset_timezone_to_utc
  before_filter :set_timezone_to_user



  attr_accessor :current_user



  protected
    def reset_timezone_to_utc
      yield
    ensure
      Time.zone = Time.zone_default
    end


    def set_timezone_to_user
      # if current_user.time_zone.nil?
      #   Time.zone = Time.zone_default
      # else
      #   Time.zone = current_user.time_zone
      # end
    end


    def authenticate
      if (token = request.headers['X-Auth-Token']).blank?
        render :json => {:error => 'You must have a valid token'}, :success => :unauthorized, status: 401
        Rails.logger.debug "No Access token"
      else
        if (current_user = User.find_by_token(token) )
          Rails.logger.debug "Authorisation Attempt #{current_user}"
          @current_user = current_user
        else
          Rails.logger.debug "Un Authorised Attempt Wrong access key"
          render :json => {:error => 'You must have an authorised token'}, :success => :unauthorized, status: 403
        end
      end
    end
end
