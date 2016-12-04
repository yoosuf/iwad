class CreateDriverReferences < ActiveRecord::Migration
  def change
    create_table :driver_references do |t|
      t.string          :name
      t.string          :how_long_know
      t.string          :relationship
      t.string          :organization
      t.string          :postcode
      t.string          :email
      t.string          :telephone
      t.string          :address
      t.integer         :driver_id
      t.integer         :is_contacted_prior_to_interview
      t.timestamps null: false
    end
  end
end
