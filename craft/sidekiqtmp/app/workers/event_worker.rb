puts "ewewew"
class EventWorker
  puts "ewewew include"
  include Sidekiq::Worker
  # sidekiq_options queue: :event

  def perform(id)
    puts "ewewew preform"
    puts id
    #@event = Event.find(id)
    #puts @event
  end
end
