class AddSessionTokenToDriver < ActiveRecord::Migration
  def change
    add_column :drivers, :session_token, :string
  end
end
