class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string      :name
      t.date        :start_date
      t.date        :end_date
      t.string			:description
      t.boolean :status, null: false, default: 0
      t.timestamps null: false
    end
  end
end
