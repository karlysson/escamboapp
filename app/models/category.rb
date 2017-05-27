class Category < ActiveRecord::Base

    #Gem FriendlyIs
    include FriendlyId
    friendly_id :description, use: :slugged

    #Associations
    has_many :ads

    #Validations
    validates_presence_of :description

    #Scope
    scope :order_by_description, -> {order(:description)}

end
