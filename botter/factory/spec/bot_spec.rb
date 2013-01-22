#!ruby
# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# ボット：認証と発言に責任を持つこと
describe Bot do
  before do
    @botTest = Bot.new
  end
  
  it "インスタンスを作成できること" do
    
  end
  
  it "時間的に発言OKかどうか返す(0時～7時)" do
    # 0時は寝てる
    @botTest.isSleeping(0).should be_false
    # 1時は寝てる
    @botTest.isSleeping(1).should be_false
    # 7時は起きてる
    @botTest.isSleeping(7).should be_true
    # 8時は起きてる
    @botTest.isSleeping(8).should be_true
    # 13時は起きてる
    @botTest.isSleeping(13).should be_true
    # 23時は起きてる
    @botTest.isSleeping(23).should be_true
  end
  
  it "リスト：1文字以上の文字列が返却されること" do
    @botTest.getList.should be_a_kind_of String
    @botTest.getList.should_not be_nil
  end
  
  it "黙示録：「章━」で終わる文字列が返却されること" do
    @botTest.getApocalypse.should be_a_kind_of String
    @botTest.getApocalypse.should_not be_nil
    @botTest.getApocalypse.should match "章━$"
  end
  
  it "場所：「そうだ」で始まる文字列が返却されること" do
    @botTest.getTabisaki.should be_a_kind_of String
    @botTest.getTabisaki.should_not be_nil
    @botTest.getTabisaki.should match "^そうだ"
  end
  
  
end
