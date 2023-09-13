class AddBuildingNameToPurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_records, :building_name, :string
  end
end
