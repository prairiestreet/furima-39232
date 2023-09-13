class AddPostalCodeToPurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_records, :postal_code, :string
  end
end