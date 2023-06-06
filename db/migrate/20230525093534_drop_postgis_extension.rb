class DropPostgisExtension < ActiveRecord::Migration[7.0]
  def change
    disable_extension 'postgis'
  end
end
