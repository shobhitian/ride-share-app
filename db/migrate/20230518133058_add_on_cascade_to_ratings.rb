class AddOnCascadeToRatings < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :ratings, :publishes
    add_foreign_key :ratings, :publishes, on_delete: :cascade
  end
end
