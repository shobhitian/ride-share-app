class AddEstimateTimeToPublishes < ActiveRecord::Migration[7.0]
  def change
    add_column :publishes, :estimate_time, :time
  end
end
