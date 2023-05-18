class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :rated_user, null: false, foreign_key: { to_table: :users }
      t.references :rating_user, null: false, foreign_key: { to_table: :users }
      t.references :publish, foreign_key: true  # Add the publish_id column

      t.integer :value, null: false
      t.timestamps
    end

   
  end
end
