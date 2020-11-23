class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :specialty
      t.string :address
      t.string :homepage
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
