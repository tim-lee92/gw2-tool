class AddUseridToDonations < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :user_id, :integer
  end
end
