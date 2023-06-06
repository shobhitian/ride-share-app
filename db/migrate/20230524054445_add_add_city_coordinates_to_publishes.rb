class AddAddCityCoordinatesToPublishes < ActiveRecord::Migration[7.0]
  def change
    add_column :publishes, :add_city_longitude, :float
    add_column :publishes, :add_city_latitude, :float
  end
end
