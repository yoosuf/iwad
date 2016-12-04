class Api::V1::B2b::UsersController < UserApiController
  before_filter :authenticate, :except => [:create, :login]


  def login
    user = User.login(params[:email], params[:password])
    if user.length == 0
      render :json => {:success => :false, :errors => ['Email password combination invalid']}, status: 422
    else
      if params[:push_token] && params[:device_type]
        user[0].updateUserHandset(params[:push_token], params[:device_type])
        user[0].set_time_zone_to_user(params[:time_zone])
        # user[0].new_token!
      end
      render :json => {:success => :true , :user => user[0].as_json(:methods => [:avatar_url])}
    end
  end


  def create
    exUser = User.authenticate(params[:email])
    if exUser.length == 0
      user = User.new(user_params)
      user.status = 1
      if user.save
        if params[:push_token] && params[:device_type]
          user[0].updateUserHandset(params[:push_token], params[:device_type])
          # user[0].new_token!
        end
        render :json => {:success => :true , :user => user.as_json(:methods => [:avatar_url])}, status: 200
      else
        render :json => {:success => :false , :errors => user.errors.full_messages}, status: 422
      end
    else
      render :json => {:success => :false , :errors => ['Email already exits']}, status: 422
    end
  end

  def logout
    if params[:push_token] && params[:device_type]
      current_user.removeDevices(params[:push_token], params[:device_type])
      render :json => {:success => :true , :message => 'log out'}
    else
      render :json => {:success => :false , :errors => ['required fields are blank']}, status: 422
    end
  end

  api :GET, '/v1/b2b/users/', 'Fetch details of the current user'
  formats ['json']
  description <<-EOS
      == Long description
       Fetch the details of the current user
    EOS
  def show
    if current_user
      render :json => {:success => :true , :user => current_user.as_json(:methods => [:avatar_url])}
    else
      render :json => {:success => :false , :errors => ['You dont have user details']}
    end
  end

  def update
    if current_user.update(user_update_params)
      render :json => {:success => :true , :user =>  current_user.as_json(:methods => [:avatar_url])}
    else
      render :json => {:success => :false , :errors => current_user.errors.full_messages}, status: 422
    end
  end

  def change_password
    if params[:password] && params[:confirm_password] && params[:old_password]
      if params[:password] == params[:confirm_password]

        if current_user.password == Digest::SHA1.hexdigest(params[:old_password])
          current_user.updatePassword(params[:password])
          current_user.save
          render :json => {:success => :true , :user =>  current_user.as_json(:methods => [:avatar_url])}
        else
          render :json => {:success => :false , :errors => ["old password doesn't match"]}
        end
      else
        render :json => {:success => :false , :errors => ["password doesn't match"]}
      end
    else
      render :json => {:success => :false , :errors => ['field are blanks']}
    end
  end


  private
    def user_update_params
      params.permit(:name, :date_of_birth, :gender, :phone_no,:password, :avatar, :country_code, :organisation_name, :time_zone, :token)
    end

    def user_params
      params.permit(:name, :email, :date_of_birth, :gender, :phone_no,:password, :country_code, :organisation_name, :time_zone, :token)
    end
end
