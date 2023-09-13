class AddAddressToPurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_records, :address, :string
  end
end
