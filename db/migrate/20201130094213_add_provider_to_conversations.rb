class AddProviderToConversations < ActiveRecord::Migration[6.0]
  def change
    add_reference :conversations, :provider, null: false, foreign_key: true
  end
end
