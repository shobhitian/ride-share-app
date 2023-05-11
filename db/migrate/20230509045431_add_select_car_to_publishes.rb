class AddSelectCarToPublishes < ActiveRecord::Migration[7.0]
  def change
    add_column :publishes, :select_car, :string
  end
end
