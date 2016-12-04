class AddRehabilitaionFields < ActiveRecord::Migration
  def change
    add_column :drivers, :is_convictions_unspent_under_rehabilitation , :integer,  default: 0
    add_column :drivers, :convictions_unspent_under_rehabilitation_info , :string
    add_column :drivers, :is_criminal_offence , :integer,  default: 0
    add_column :drivers, :criminal_offence_info , :string
  end
end
