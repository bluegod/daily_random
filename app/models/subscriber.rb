class Subscriber < ActiveRecord::Base
  validates :email, :uniqueness => { :case_sensitive => false }

  #some general email validation
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
