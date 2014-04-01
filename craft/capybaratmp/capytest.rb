#!ruby
# coding: utf-8
=begin
=end

require 'minitest/unit'
MiniTest::Unit.autorun

require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'


class TestCapy < MiniTest::Unit::TestCase
  include Capybara::DSL
  
  def testCapy
    assert true
  end
end
