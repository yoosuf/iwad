class AddDocumentsToDriver < ActiveRecord::Migration
  def self.up
    change_table :drivers do |t|
      t.attachment :photo_of_self
      t.attachment :license_paper
      t.attachment :license_photo_id
      t.attachment :utility_bill
      t.attachment :passport
      t.attachment :bank_details
      t.attachment :national_insurance
      t.attachment :git_insurance
      t.attachment :emergency_document
      t.attachment :uniform_info
      t.attachment :vehicle_insurance_certificate
      t.attachment :vehicle_registration_document
      t.attachment :vehicle_m_o_t_certificate
      t.attachment :vehicle_rental_agreement
      t.attachment :vehicle_photo
      t.attachment :vehicle_road_tax
    end
  end

  def self.down
  end
end
