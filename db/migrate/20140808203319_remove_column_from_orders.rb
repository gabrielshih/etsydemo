class RemoveColumnFromOrders < ActiveRecord::Migration
  def change
      remove_column :orders, :seller_id
  end
end
