class Addcolumntousers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :travel_preferences, :string
    add_column :users, :postal_address, :text
  end
end
