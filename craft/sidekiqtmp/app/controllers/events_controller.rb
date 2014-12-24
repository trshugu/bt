puts "anisoro"
class EventsController
  puts "naninaka"
  
  def index
    puts "indind"
  end
  
  def ranking
    puts "ececec"
    EventWorker.perform_async 1
    puts "asinku!!"
  end
end
