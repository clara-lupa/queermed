class RemoveAddressFromProviders < ActiveRecord::Migration[6.0]
  def change
    remove_column :providers, :address, :string
  end
end
