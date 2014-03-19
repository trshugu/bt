class SpispiController < ApplicationController
  def index
    @res = rand(1000).to_s
    puts "geeeee"
  end
end
