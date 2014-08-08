class RemoveFieldsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :buyer_id, :integer
    remove_column :orders, :seller_id, :integer
  end
end
