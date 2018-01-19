class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :set_layout

  def authenticate_diver!(options={})
    if driver_signed_in?
    else
      redirect_to new_driver_session_path, :notice => 'Login as Driver'
    end
  end

  def authenticate_admin_user!(options={})
    if admin_user_signed_in?
      super
    else
      redirect_to new_admin_user_session_path, :notice => 'Login as admin'
    end
  end

  def set_layout
    path = self.controller_path.split('/')
    @namespace = path.second ? path.first : nil

    if @namespace == 'drivers' || @namespace == '' || @namespace.nil?
      if driver_signed_in?
        'application'
      else
        'application-anonymous'
      end
    else
      if admin_user_signed_in?
        'application-admin'
      else
        'application-admin-anonymous'
      end
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :club
      root_path
    elsif resource_or_scope == :admin_user
      admin_root_path
    else
      super
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Driver)
      driver_index_path
    elsif resource_or_scope.is_a?(AdminUser)
      admin_root_path
    else
      super
    end
  end
end