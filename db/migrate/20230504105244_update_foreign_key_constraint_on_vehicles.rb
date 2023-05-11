class UpdateForeignKeyConstraintOnVehicles < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :vehicles, :users
    add_foreign_key :vehicles, :users, on_delete: :cascade
  end
end
