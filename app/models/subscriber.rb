require 'jobs/helpers/job_status_retriever'

class Subscriber < ActiveRecord::Base
  include Tokenable
  validates :email, :uniqueness => { :case_sensitive => false }

  #some general email validation
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_uniqueness_of :token

  def live_status
    JobStatusRetriever.get(email)
  end
end
