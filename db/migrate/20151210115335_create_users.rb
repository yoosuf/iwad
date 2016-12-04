class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string      :name
      t.string      :email
      t.string      :password
      t.string			:gender, limit: 6
      t.date        :date_of_birth
      t.string      :phone_no
      t.string      :token
      t.boolean :status, null: false, default: 0
      t.timestamps null: false
    end
  end
end
