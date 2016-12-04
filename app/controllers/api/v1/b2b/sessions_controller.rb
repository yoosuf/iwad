class Api::V1::B2b::SessionsController < UserApiController

  before_filter :authenticate, :except => [:check]


  #
  # Check where user exist
  #
  def check
    if (token = request.headers['X-Auth-Token'])
      if (current_user = User.find_by_token(token))

        if params[:push_token] && params[:device_type]
          current_user[0].updateUserHandset(params[:push_token], params[:device_type])
          current_user[0].set_time_zone_to_user(params[:time_zone])
          # user[0].new_token!
        end


        # if params[:push_token] && params[:device_type]
        #   current_user[0].updateUserHandset(params[:push_token], params[:device_type])
          # current_user[0].set_time_zone_to_user(params[:time_zone])
          # user[0].new_token!
        # end
        render :json => {:success => :true , :user => current_user.as_json(:methods => [:avatar_url])}
      else
        render :nothing => true, :status => 401, :json => {:success => :false }
      end
    else
      render :nothing => true, :status => 403, :json => {:success => :false }
    end
  end

end
