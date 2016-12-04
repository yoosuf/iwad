class AddPrePaidCoutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prepaid_credit_count, :integer,  default: 0

  end
end
