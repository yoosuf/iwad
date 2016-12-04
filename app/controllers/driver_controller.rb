class DriverController < ApplicationController
  before_action :authenticate_diver!, :except => [:terms]
  layout "blank", only: [:terms]

  # before_action :configure_permitted_parameters, if: :devise_controller?

  def index
  end

  def personal_info
    @driver = current_driver
    if request.post?
      if @driver.update(driver_personal_info_update_params)
        redirect_to personal_info_driver_index_path
      end
    end
  end

  def employment_info
    @driver = current_driver
    if request.post?
      if @driver.update(driver_employment_info_params)
        flash[:notice] =  'Driver successfully updated.'
        redirect_to employment_info_driver_index_path
      else
      end
      #redirect_to confirmation_driver_index_path
    end
  end

  def health
    @driver = current_driver
    if request.post?

      if @driver.update(driver_health_params)
        redirect_to health_driver_index_path
      end
    else

    end
  end

  def rehabilitation
    @driver = current_driver

    if request.post?
      if @driver.update(driver_rehabilitation_params)
        redirect_to rehabilitation_driver_index_path
      end
    else

    end
  end

  def verification
    @driver = current_driver
    if request.post?
      if @driver.update(driver_verification_params)
        redirect_to verification_driver_index_path
      end
    end
  end

  def driving_license
    @driver = current_driver
    @driver.validationType = 6
    if request.post?
      if @driver.saveDriving_license(driver_driving_license_params)
        logger.debug "Person attributes hash: #{@driver.validationType}"
        redirect_to driving_license_driver_index_path
      end
    else

    end
  end

  def references
    @driver = current_driver
    @driver.validationType = 7
    if request.post?
      if @driver.update(driver_diver_references_params)
        redirect_to references_driver_index_path
      end
    end
  end

  def supporting_documents
    @driver = current_driver
    @driver.validationType = 8
    if request.post?
      if @driver.update(driver_supporting_documents_params)
        redirect_to supporting_documents_driver_index_path
      end
    end
  end

  def declaration_consent
    @driver = current_driver
    @driver.validationType = 9
    if request.post?
      if @driver.update(driver_declaration_consent_params)
        redirect_to declaration_consent_driver_index_path
      end
    end
  end

  def equal_opportunities
    @driver = current_driver
    @driver.validationType = 10
    if request.post?
      if @driver.update(driver_equal_opportunities_consent_params)
        redirect_to equal_opportunities_driver_index_path
      end
    end
  end

  def confirmation
    @driver = current_driver
    @driver.validationType = 11

    if request.post?
      if @driver.update(driver_confirmation_params)
        flash[:notice] =  'Driver successfully updated.'
        redirect_to confirmation_driver_index_path
      else

      end
        #redirect_to confirmation_driver_index_path
    end
  end

  def update
    @driver = current_driver

    if @driver.update(params[:employments_attributes])
    end
  end


  def terms
  end

  protected

    def driver_confirmation_params
      params.require(:driver).permit(:abt_position)
    end
    def driver_employment_info_params
      params.require(:driver).permit(:employment_gaps_attributes => [:id, :reason, :to_date, :from_date],:employments_attributes => [:id, :name, :post_title, :salary, :address, :appointment_date, :last_day, :department, :notice_period,:duty_description, :leaving_reason])
    end

    def driver_health_params
      params.require(:driver).permit( :no_of_absent_dates, :absent_desc)
    end

    def driver_rehabilitation_params
      params.require(:driver).permit( :is_convictions_unspent_under_rehabilitation, :convictions_unspent_under_rehabilitation_info, :is_criminal_offence, :criminal_offence_info)
    end

    def driver_driving_license_params
      params.require(:driver).permit( :is_license_valid_in_uk, :license_no,:is_endorsements_on_license, :is_blameworthy_accidents, :blameworthy_accident_info)
    end

    def driver_declaration_consent_params
      params.require(:driver).permit( :declaration_agreement)
    end

    def driver_supporting_documents_params
      params.require(:driver).permit( :photo_of_self,:license_paper,:license_photo_id,:utility_bill,:passport,:bank_details,:national_insurance,:git_insurance,:emergency_document,:uniform_info,:vehicle_insurance_certificate,:vehicle_registration_document,:vehicle_m_o_t_certificate,:vehicle_rental_agreement,:vehicle_photo,:vehicle_road_tax)
    end

    def driver_diver_references_params
      params.require(:driver).permit(:driver_references_attributes => [:id, :name, :how_long_know, :relationship, :address, :organization, :postcode, :email, :telephone, :is_contacted_prior_to_interview])

    end

    def driver_equal_opportunities_consent_params
      params.require(:driver).permit( :is_any_other_background, :ethnicity_info, :disability_info, :ethnicity, :sexual_orientation, :date_of_birth, :is_disability)
    end

    def driver_verification_params
      params.require(:driver).permit( :is_legal_restrictions, :_is_bring_passport_for_interview, :_is_bring_certificate_for_interview, :_is_bring_work_visa_for_interview, :_is_bring_other_for_interview, :other_doc_for_interview)
    end

    def driver_personal_info_params
      params.require(:driver).permit( :is_any_other_background, :ethnicity_info, :disability_info, :ethnicity, :sexual_orientation, :date_of_birth, :is_disability, :delivery_vehicle_id)
    end

    def driver_personal_info_update_params
      params.require(:driver).permit(:password, :password_confirmation, :title, :first_name, :surname, :middle_name, :mobile_no, :land_no, :gender, :delivery_vehicle_id)
    end
end
