class AddAbtPositionToDriver < ActiveRecord::Migration
  def change
    add_column :drivers, :abt_position, :string, limit: 2000
  end
end
