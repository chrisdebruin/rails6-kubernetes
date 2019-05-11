class LogJob < ApplicationJob
  queue_as :default

  def perform
    Log.create(message: "Log message #{Time.zone.now}")
    # Do something later
  end
end
