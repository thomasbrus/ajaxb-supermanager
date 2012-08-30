class Message
  include ActiveAttr::Model
  
  attribute :name
  attribute :email
  attribute :content
  attribute :receiver
  
  attr_accessible :name, :email, :content, :receiver
  validates_presence_of :name, :email, :receiver, :content
  validates_length_of :content, maximum: 700
  #validates_inclusion_of :receiver, in: RECEIVERS.map(&:email)

end