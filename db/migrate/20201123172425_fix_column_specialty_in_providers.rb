class FixColumnSpecialtyInProviders < ActiveRecord::Migration[6.0]
  def change
    rename_column :providers, :specialty, :speciality
  end
end
