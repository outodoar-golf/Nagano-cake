class RemoveAdminFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :admin, :boolean
  end
end
