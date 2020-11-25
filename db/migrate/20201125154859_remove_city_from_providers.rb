class RemoveCityFromProviders < ActiveRecord::Migration[6.0]
  def change
    remove_column :providers, :city, :string
  end
end
