class AddPhoneToPurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :purchase_records, :phone_number, :string
  end
end
