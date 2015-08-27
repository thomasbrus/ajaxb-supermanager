class Message
  include ActiveAttr::Model

  attribute :name
  attribute :email
  attribute :content
  attribute :receipent

  validates_presence_of :name, :email, :receipent, :content
  validates_length_of :content, maximum: 700
end
