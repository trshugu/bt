# coding:utf-8
# language: ja

require "./betweenhourV2.rb"

もし(/^すべて同じ数字$/) do
  @bhTest = BetweenHour.new
  @res = @bhTest.isBetweenHour(1,1,1)
end

ならば(/^nilであること$/) do
  @res == nil
end


