class Message
  include ActiveModel::Model

  attr_accessor :name
  attr_accessor :email
  attr_accessor :content
  attr_accessor :recipient
  attr_accessor :spam_check


  validates_presence_of :name, :email, :recipient, :content
  validates_length_of :content, maximum: 700
  validates :spam_check, numericality: { equal_to: 12 }
end
