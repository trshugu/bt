# require "./app/controllers/events_controller.rb"
class FrontsController < ApplicationController
  def index
    puts "fonfonr"
    EventWorker.perform_async 2
  end
  
end
