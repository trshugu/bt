#!ruby
# coding: utf-8
=begin
=end

require "./Concrete1"
require "./Concrete2"

res = ""
strategy = nil
val = "000"

case val
  when "one"
    strategy = Concrete1.new
  when "two"
    strategy = Concrete2.new
  else
    strategy = Strategy.new
end

strategy.output
