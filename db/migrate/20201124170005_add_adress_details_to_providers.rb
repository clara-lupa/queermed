class AddAdressDetailsToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :street, :string
    add_column :providers, :city, :string
  end
end
