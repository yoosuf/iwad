class Api::V1::Driver::SessionsController < DriverApiController
  before_filter :authenticate, :except => [:check]

  #
  # Check where user exist
  #
  def check

    if (token = request.headers['X-Auth-Token'])
      if (current_user = Driver.find_by_token(token))
        @current_user = current_user

        if params[:push_token] && params[:device_type]
          @current_user[0].updateUserHandset(params[:push_token], params[:device_type])
        end
        @current_user.set_time_zone_to_driver(params[:timezone])

        render :json => {:success => :true , :user => @current_user.as_json(:methods => [:avatar_url])}
      else
        render :nothing => true, :status => 401, :json => {:success => :false }
      end
    else
      render :nothing => true, :status => 403, :json => {:success => :false }
    end
  end

end
