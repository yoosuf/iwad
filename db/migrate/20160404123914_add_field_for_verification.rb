class AddFieldForVerification < ActiveRecord::Migration
  def change
    add_column :drivers, :is_legal_restrictions, :integer, default:0
    add_column :drivers, :_is_bring_passport_for_interview, :integer, default:0
    add_column :drivers, :_is_bring_certificate_for_interview, :integer, default:0
    add_column :drivers, :_is_bring_work_visa_for_interview, :integer, default:0
    add_column :drivers, :_is_bring_other_for_interview, :integer, default:0
    add_column :drivers, :other_doc_for_interview, :string
  end
end
