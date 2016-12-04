class Admin::UsersController < AdminController

  before_action :set_user, only: [:show, :edit, :update, :report]

  def index
    if params[:q].nil? || params[:q].empty?
      @users  = User.paginate(:page => params[:page], :per_page => 20).where(:status => 1)
      .order("created_at DESC")

    else
    
        if params[:option] == "id"
        
            @users  = User.paginate(:page => params[:page], :per_page => 20).where('id = ?',"#{params[:q]}")
            .order("created_at DESC")

        elsif params[:option] == "name"

            @users  = User.paginate(:page => params[:page], :per_page => 20).where('name LIKE ?',"%#{params[:q]}%")
            .order("created_at DESC")

        elsif params[:option] == "email"

            @users  = User.paginate(:page => params[:page], :per_page => 20).where('email = ?',"#{params[:q]}")
            .order("created_at DESC")


        elsif params[:option] == "org"
        
            @users  = User.paginate(:page => params[:page], :per_page => 20).where('organisation_name LIKE ?',"%#{params[:q]}%")
            .order("created_at DESC")
        
        end
      
    end
  end

  def show
  end

  def edit
  end

  def deactive
    if params[:keyword].nil? || params[:keyword].empty?
      @users  = User.paginate(:page => params[:page], :per_page => 20).where(:status => 0).order("created_at DESC")

    else
      @users  = User.paginate(:page => params[:page], :per_page => 20).where('(status = 0 AND organisation_name LIKE (?) OR name LIKE (?) OR email LIKE (?))',"%#{params[:keyword]}%","%#{params[:keyword]}%","%#{params[:keyword]}%").order("created_at DESC")
    end
  end

  def update
    if params[:generate]
      redirect_to report_admin_users_path(format: :pdf, :user_id => params[:id], :target => "_blank")
    else
      # logger.debug "ADMIN UPDATE ACTION FOR USER #{@user}"
      # Rails.logger.info(@user.errors.messages.inspect)

      # @user.set_prepaid_credits(params[:user][:prepaid_credit_count])

      @user.update(user_params)
      logger.debug "ADMIN UPDATE ACTION"


      redirect_to action: 'index'
    end
  end

  def report
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "report"
      end
    end
  end


  protected
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:prepaid_credit_count, :status)
    end
end
