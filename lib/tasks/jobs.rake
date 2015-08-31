require 'rake'

namespace :jobs do
  desc "Run a Qless worker"
  task :daily => :environment do
    # Load your application code. All job classes must be loaded.
    require 'jobs/daily_quote_manager'
    require 'jobs/daily_sender'

    # Require the parts of qless you need
    require 'qless'
    require 'qless/job_reservers/ordered'
    require 'qless/worker'

    # Create a client
    client = Qless::Client.new

    # Get the queue
    queue = client.queues[ENV['default_queue']]

    # Create a job reserver; different reservers use different
    # strategies for which order jobs are popped off of queues
    reserver = Qless::JobReservers::Ordered.new([queue])

    # Create a forking worker that uses the given reserver to pop jobs.
    worker = Qless::Workers::ForkingWorker.new(reserver)

    # Start the worker!
    worker.run

  end

  desc "Add daily task"
  task :daily => :environment do
    # Load your application code. All job classes must be loaded.
    require 'jobs/daily_quote_manager'
    require 'jobs/daily_sender'

    # Require the parts of qless you need
    require 'qless'
    require 'qless/job_reservers/ordered'
    require 'qless/worker'

    # Create a client
    client = Qless::Client.new

    # Get the queue
    queue = client.queues[ENV['default_queue']]

    #add recurring daily job
    queue.recur(DailyQuoteManager, {}, 3600*24)
  end
end