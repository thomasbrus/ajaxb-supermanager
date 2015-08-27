class Message
  include ActiveModel::Model

  attr_accessor :name
  attr_accessor :email
  attr_accessor :content
  attr_accessor :receipent

  validates_presence_of :name, :email, :receipent, :content
  validates_length_of :content, maximum: 700
end
