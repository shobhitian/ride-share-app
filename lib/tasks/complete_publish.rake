namespace :publish do
    desc "Complete publish task"
    task complete_publish: :environment do
      publishes = Publish.where("date <= ? AND status = ?", 1.day.ago, "pending")
  
      publishes.each do |publish|
        publish.update(status: "completed")
        puts "Publish #{publish.id} completed."
      end
  
      puts "Complete publish task finished."
    end
  end

