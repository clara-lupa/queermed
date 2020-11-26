class RemoveStreetFromProviders < ActiveRecord::Migration[6.0]
  def change
    remove_column :providers, :street, :string
  end
end
