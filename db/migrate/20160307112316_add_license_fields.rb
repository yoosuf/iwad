class AddLicenseFields < ActiveRecord::Migration
  def change
    add_column :drivers, :is_license_valid_in_uk , :integer,  default: 0
    add_column :drivers, :license_no , :string
    add_column :drivers, :is_endorsements_on_license , :integer,  default: 0
    add_column :drivers, :is_blameworthy_accidents , :integer,  default: 0
    add_column :drivers, :blameworthy_accident_info , :string
  end
end
