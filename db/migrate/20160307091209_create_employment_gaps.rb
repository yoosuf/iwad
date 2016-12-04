class CreateEmploymentGaps < ActiveRecord::Migration
  def change
    create_table :employment_gaps do |t|

      t.timestamps null: false
      t.date        :from_date
      t.date        :to_date
      t.string      :reason
      t.integer     :driver_id, :integer, null: false,  default: 0
    end
  end
end
