class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.string      :name
      t.string      :post_title
      t.string      :salary
      t.string      :address
      t.date        :appointment_date
      t.date        :last_day
      t.string      :department
      t.string      :notice_period
      t.string      :duty_description
      t.string      :leaving_reason
      t.integer :is_present , null: false, default: 0
      t.timestamps null: false
    end
  end
end
