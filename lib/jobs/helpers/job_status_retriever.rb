require 'config/daily_cached'

class JobStatusRetriever
  def initialize(job_id)
    @job_id = job_id
  end

  def self.get(job_id)
    new(job_id).get
  end

  def get
    job = DailyCached.qless.jobs[@job_id]
    if job.nil?
      'scheduled'
    else
      date = job.queue_history.last['when'].to_s(:short)
      status = job.queue_history.last['what']
      "#{status} on #{date}"
    end
  end
end