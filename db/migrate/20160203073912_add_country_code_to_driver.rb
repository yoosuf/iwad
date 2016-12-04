class AddCountryCodeToDriver < ActiveRecord::Migration
  def change
    add_column :drivers, :country_code, :string
  end
end
