class Drivers::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up).push(:email, :password, :password_confirmation, :title, :first_name, :surname,
    #                                  :middle_name, :mobile_no, :land_no, :gender, :delivery_vehicle_id)

    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :title, :first_name, :surname,
                                                       :middle_name, :mobile_no, :land_no, :gender, :delivery_vehicle_id])

  end


  # def sign_up_param
  #   params.require(:driver).permit(:email, :password, :password_confirmation, :title, :first_name, :surname,
  #                                :middle_name, :mobile_no, :land_no, :gender, :delivery_vehicle_id)
  # end

end
