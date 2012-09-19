# coding: utf-8

require './tmp.rb'
require 'rack/lobster'

map '/simple' do
  run RackApp.new
end

map '/lobster' do
  run Rack::Lobster.new
end