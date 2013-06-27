# coding: utf-8
require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'

Capybara.default_driver = :webkit

include Capybara::DSL

前提 /\"(.+)\"を表示/ do |url|
  visit(url)
end

ならば /スクリーンショットを取得し\"(.+)\"に保存/ do |filename|
  page.save_screenshot "./#{filename}"
end
