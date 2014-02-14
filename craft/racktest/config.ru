# coding: utf-8

require './rack.rb'
require 'rack/lobster'

map '/simple' do
  run Rerack
end

map '/lobster' do
  run Rack::Lobster.new
end