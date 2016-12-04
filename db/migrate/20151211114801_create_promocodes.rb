class CreatePromocodes < ActiveRecord::Migration
  def change
    create_table :promocodes do |t|
      t.string      :code
      t.date        :start_date
      t.date        :end_date
      t.string			:description
      t.timestamps null: false
    end
  end
end
