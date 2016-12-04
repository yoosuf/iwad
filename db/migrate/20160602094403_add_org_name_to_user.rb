class AddOrgNameToUser < ActiveRecord::Migration
  def change
    add_column :users , :organisation_name, :string
  end
end
