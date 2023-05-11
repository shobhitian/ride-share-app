class CreatePassengers < ActiveRecord::Migration[7.0]
  def change
    create_table :passengers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :publish, null: false, foreign_key: true

      t.timestamps
    end
  end
end
