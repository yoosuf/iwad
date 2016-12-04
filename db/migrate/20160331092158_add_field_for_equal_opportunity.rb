class AddFieldForEqualOpportunity < ActiveRecord::Migration
  def change
    add_column :drivers, :is_any_other_background, :integer, default:0
    add_column :drivers, :ethnicity_info, :string
    add_column :drivers, :ethnicity, :string
    add_column :drivers, :disability_info, :string
    add_column :drivers, :is_disability, :integer, default:0
    add_column :drivers, :sexual_orientation, :string
  end
end
