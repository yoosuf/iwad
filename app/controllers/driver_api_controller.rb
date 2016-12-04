class DriverApiController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :authenticate
  # around_filter :reset_timezone_to_utc
  # before_filter :set_timezone_to_user
  attr_accessor :current_user

  protected
    # def reset_timezone_to_utc
    #   yield
    # ensure
    #   Time.zone = Time.zone_default
    # end

    # def set_timezone_to_user
    #
    #   return unless (user_timezone = current_user).present?
    #
    #   # user_timezone = "Europe/Lisbon"
    #
    #   Time.zone = "#{user_timezone}"
    #
    # end

    def authenticate
      if (token = request.headers['X-Auth-Token']).blank?
        render :json => {:error => 'You must have a valid token'}, :success => :unauthorized, status: 401
      else
        if (current_user = Driver.find_by_token(token) )
          @current_user = current_user

          return unless (user_timezone = current_user.time_zone).present?

          Time.zone = "#{user_timezone}"

        else
          render :json => {:error => 'You must have an authorised token'}, :success => :unauthorized, status: 403
        end
      end
    end
end
