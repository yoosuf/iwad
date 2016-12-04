class Admin::AdminNotificationsController < AdminController

  before_action :set_admin_notification, only: [:show, :edit, :update, :destroy]

  # GET /admin_notifications
  # GET /admin_notifications.json
  def index
    @admin_notifications = AdminNotification.all
  end

  # GET /admin_notifications/1
  # GET /admin_notifications/1.json
  def show
  end

  # GET /admin_notifications/new
  def new
    @admin_notification = AdminNotification.new
  end

  # GET /admin_notifications/1/edit
  def edit
  end

  # POST /admin_notifications
  # POST /admin_notifications.json
  def create
    @admin_notification = AdminNotification.new(admin_notification_params)

    if @admin_notification.save
      redirect_to admin_admin_notifications_path, notice: 'Admin notification was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin_notifications/1
  # PATCH/PUT /admin_notifications/1.json
  def update
    if @admin_notification.update(admin_notification_params)
      redirect_to admin_admin_notifications_path, notice: 'Admin notification was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin_notifications/1
  # DELETE /admin_notifications/1.json
  def destroy
    @admin_notification.destroy
    redirect_to admin_admin_notifications_path, notice: 'Admin notification was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_notification
      @admin_notification = AdminNotification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_notification_params
      params.require(:admin_notification).permit(:name, :email, :time_zone, :status)
    end
end
