class AddAddressToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :address, :string
  end
end
