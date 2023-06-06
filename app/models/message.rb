class Message < ApplicationRecord
   
    belongs_to :user
    
    # Validations
    validates :body, presence: true
    

end
