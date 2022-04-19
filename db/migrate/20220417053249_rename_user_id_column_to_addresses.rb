class RenameUserIdColumnToAddresses < ActiveRecord::Migration[6.1]
  def change
    rename_column :addresses, :user_id, :customer_id
  end
end
