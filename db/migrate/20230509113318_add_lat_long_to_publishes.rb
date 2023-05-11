class AddLatLongToPublishes < ActiveRecord::Migration[7.0]
  def change
    add_column :publishes, :source_latitude, :float
    add_column :publishes, :source_longitude, :float
    add_column :publishes, :destination_latitude, :float
    add_column :publishes, :destination_longitude, :float
  end
end
