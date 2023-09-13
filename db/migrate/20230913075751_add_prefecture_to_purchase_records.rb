class AddPrefectureToPurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_records, :prefecture, :string
  end
end