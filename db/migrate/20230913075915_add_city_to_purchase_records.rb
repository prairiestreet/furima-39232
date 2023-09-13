class AddCityToPurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_records, :city, :string
  end
end
