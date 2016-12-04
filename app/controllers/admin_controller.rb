class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_admin_user!
  before_action :authenticate_admin_user!

  before_action :set_time_zone
  layout :layout_by_resource



  def authenticate_admin_user!(options={})
    if admin_user_signed_in?
      super
    else
      redirect_to new_admin_user_session_path, :notice => 'Login as admin'
    end
  end


  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin_user
      admin_root_path
    else
      super
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(AdminUser)
      admin_root_path
    else
      super
    end
  end

  def set_time_zone
    return unless (utc_offset = cookies['browser.timezone']).present?
    Time.zone = "#{utc_offset}"
  end


  protected
    def layout_by_resource
      if devise_controller? && resource_name == :admin_user && action_name == "new"
        "application-admin-anonymous"
      else
        "application-admin"
      end
    end

end
