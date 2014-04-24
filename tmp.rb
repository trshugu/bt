#!ruby
# coding: utf-8
=begin
=end




=begin
# 文字連結
require 'digest/md5'
require 'benchmark'


digest = Digest::MD5.hexdigest("die")
# ダイジェストを並べて2Mくらいにする

Benchmark.bm do |b|
  # これは要求が実現できてなかった
  result = "22"
  b.report {
    16000000.times.each{
      result ||= "#{result}#{digest}"
    }
  }
  
  result = ""
  b.report {
    5600000.times.each{
       result.concat(digest)
    }
  }
  
  # これが一番はやかった
  result = ""
  b.report {
    5600000.times.each{
       result << digest
    }
  }
  
  result = ""
  b.report {
    10000.times.each{
       result = "#{result}#{digest}"
    }
  }
  
end
=end


=begin
# Redisテストその2
require "redis"
redis = Redis.new(:host => "127.0.0.1", :db => "asdf.db")
#aws = Redis.new(:host => "suzuki-redis.d2qtpp.0001.apne1.cache.amazonaws.com")

def bench(redis)
  puts redis.set "tmpkey","tmpvalue"
  puts redis.get "tmpkey"
  puts redis.set "tmpkeysec","tmpvalueni"
  puts redis.get "tmpkeysec"

  # 複数キー指定
  puts redis.mget "tmpkey","tmpkeysec"

  # リスト操作
  #puts redis.rpush "あああ", "this is my first tweet."
  #puts redis.lrange "あああ", 0, 100
  #10.times {|i| redis.rpush("tw", "times")}
  #redis.lrange "あああ", 0, 20

  # 計測しつつ1000回繰り返す
  st =  Time.now
  1000.times {|i| redis.rpush("ttt", "million#{i}")}
  et = Time.now
  puts et - st

  # 構造化データ
  require "json"
  tmpjson = {:id => 1, :user => "shin", :time => Time.now, :body => "hello redis!"}
  puts redis.set "tj", tmpjson.to_json
  puts JSON.parse(redis.get("tj"))
end

bench(redis)
#bench(aws)
=end


=begin
# sequel + logger
require "sequel"
require "logger"

# connect to an in-memory database
DB = Sequel.sqlite("tmp.db", :loggers => [Logger.new($stdout)])
#DB = Sequel.connect('postgres://user:password@localhost/my_db')
#DB = Sequel.postgres('my_db', :user => 'user', :password => 'password', :host => 'localhost')
#DB = Sequel.ado('mydb')

# create an items table
DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end

# create a dataset from the items table
items = DB[:items]

# populate the table
items.insert(:name => 'abc', :price => rand * 100)
items.insert(:name => 'def', :price => rand * 100)
items.insert(:name => 'ghi', :price => rand * 100)

# print out the number of records
puts "Item count: #{items.count}"

# print out the average price
puts "The average price is: #{items.avg(:price)}"
=end



=begin
# 標準入力を標準出力へ
puts gets
=end

=begin
# メアドチェック
mail_address="aaa@bbb.ccc"
if mail_address[/^[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+$/]
  puts :ok
else
  puts :ng
end
=end

=begin
# unixtimeの出し方
puts Time.now.to_i
=end


=begin
# ajax用json返却api
require 'sinatra'
require "sinatra/reloader" if development?
require "json"

get '/' do
  '{"result":"done"}'
end
=end


=begin
# ModelAPIの作成
require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  @val = params[:aaa] ? params[:aaa] : ""
  "done" + @val
end

get '/write/:val' do
  File::open("api.txt", "w") do |f|
    f.write(params[:val])
  end
  "done"
end

get '/sina/' do
  File::open("sina.txt", "r").read
end

get '/sina/:id' do
  File::open("sina.txt", "r").read
end

post '/sina/' do
  puts params[:id]
  File::open("sina.txt", "w") do |f|
    f.write("sina")
  end
  "done"
end

put '/sina/' do
  File::open("sina.txt", "w") do |f|
    f.write("sina")
  end
  "done"
end

delete '/sina/' do
  File::open("sina.txt", "w") do |f|
    f.write("sina")
  end
  "done"
end

options '/sina/' do
  "done"
end
=end




=begin
# case式の判定 最終行が改行でも最後のコマンドが格納される
result = ""
val = "one"
result = case val
  when "one"
    "ooo"
    
  when "two"
    "ttt"
    
end

puts result
=end



=begin
# extendとmodule_function
module Ex
  # moduleメソッドのみ
  module ModuleMethods
    def method1 ;puts "Ex1"; end
    def method2 ;puts "Ex2"; end
  end
  
  extend ModuleMethods
end

module Mf
  def method1 ;puts "Mf1"; end
  def method2 ;puts "Mf2"; end
  
  module_function :method1
  module_function :method2
end

Ex.method1
Ex.method2
Mf.method1
Mf.method2

extend Ex
extend Mf
=end


=begin
# ASCII文字変換
module Flip
  @A = ["A", "B", "C", "D", "E", "F", "G",
    "H", "I", "J", "K", "L", "M", "N", "O",
    "P", "Q", "R", "S", "T", "U", "V", "W",
    "X", "Y", "Z", "a", "b", "c", "d", "e",
    "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u",
    "v", "w", "x", "y", "z", "0", "1", "2",
    "3", "4", "5", "6", "7", "8", "9", ".",
    ",", "-", ":", ";", "!", "?", "&", "(",
    ")", "<", ">", "[", "]", "_", "‾", "{",
    "}", "∴", "∵", " "]
  @B = ["ᗄ", "ᗺ", "Ɔ", "ᗡ", "Ǝ", "Ⅎ", "⅁",
    "H", "I", "ᒋ", "丬", "⅂", "W", "N", "O", 
    "Ԁ", "Ό", "ᴚ", "S", "⊥", "Ո", "Λ", "M",
    "X", "⅄", "Z", "ɐ", "q", "ɔ", "p", "ə",
    "ɟ", "ɓ", "ɥ", "ᴉ", "ɾ", "ʞ", "l", "ɯ",
    "u", "o", "d", "b", "ɹ", "s", "ʇ", "n",
    "ʌ", "ʍ", "x", "ʎ", "z", "0", "⇂", "Ƨ",
    "ε", "ᔭ", "5", "9", "L", "8", "6", "˙",
    "‘", "-", ":", "؛", "¡", "¿", "⅋", ")",
    "(", ">", "<", "]", "[", "‾", "_", "}",
    "{", "∵", "∴", " "]
  
  @T = @A.zip(@B)
  @H = Hash[ @T ]
  @Hi = @H.invert
  
  def self.flip(str)
    str.chars.map { |chr| @H[chr] }.join.reverse
  end
  
  def self.unflip(str)
    str.chars.map { |chr| @Hi[chr] }.join.reverse
  end
  
end

puts Flip.flip("DJhugu")
puts Flip.unflip(Flip.flip("DJhugu"))
=end


=begin
# module_function
module Mf
  extend self
  def foo
    p "modulefunction"
  end
  
  #module_function :foo
end

module M
  extend self
  def baa
    p "baa"
  end
  
  def self.baa
    p "self"
  end
  
  module_function :baa
end

Mf.foo
M.baa


class C
  include Mf
  include M
  
  def hoge
    p "hoge"
  end
end

C.new.hoge
C.new.baa
#C.new.foo

#C.hoge
#C.baa
#C.foo

class D
  extend Mf
  extend M
  
  def huga
    p "huga"
  end
end

D.new.huga
#D.new.baa
#D.new.foo

#D.hoge
D.baa
#D.foo
=end



=begin
# extend
module TestModule
  def say
    p "hello"
  end
end

class Ec
  extend TestModule
end
e = Ec.new
#e.say
Ec.say
e.extend TestModule
e.say
=end



=begin
# モジュール関数
module TestModule
  def say
    p "hello"
  end
  
  # モジュールの特異メソッド
  def self.say
    p "self"
  end
  
  module_function :say
end

# 特異メソッドとして呼び出し
TestModule.say

include TestModule
class TestClass
  def saysay
    say
  end
end

# インスタンスからも呼べる
TestClass.new.saysay
=end



=begin
# mix-inに関しての考察 モジュール
module Tm
  def say
    puts "instance"
  end
  
  def self.say
    puts "self"
  end
end

# 特異メソッドが呼び出される
Tm.say

# mix-in
class Ic
  include Tm
end

i = Ic.new
i.say
=end


=begin
# mix-inに関しての考察 継承
class Sup
  def super_say
    puts "super"
  end
end

class Sub < Sup
  def sub_say
    puts "sub"
  end
  
  def super_say
    puts "sub_super"
    super
  end
end

sb = Sub.new
sb.sub_say
sb.super_say
=end


=begin
# Javaの多態性に関しての考察2
class One
  def to
    self.s
  end
end

class Da < One
  def s
    puts "aaa"
  end
end
class Du < One
  def s
    puts "uuu"
  end
end

o=One.new
a=Da.new
u=Du.new

a.to
u.to
=end




=begin
# Javaの多態性に関しての考察
class One
  def to(d)
    d.s
  end
end

class Da
  def s
    puts "aaa"
  end
end
class Du
  def s
    puts "uuu"
  end
end

o=One.new
a=Da.new
u=Du.new

o.to a
o.to u
=end


=begin
# rubyでPOST
require 'uri'
require 'net/http'

def http_request(method, uri, query_hash={})
  query = query_hash.map{|k, v| "#{k}=#{v}"}.join('&')        #ハッシュをオプションの書式に変換
  query_escaped = URI.escape(query)
  
  uri_parsed = URI.parse(uri)
  http = Net::HTTP.new(uri_parsed.host)
  
  case method.downcase!
  when 'get'
    return http.get(uri_parsed.path + '?' + query_escaped).body
  when 'post'
    return http.post(uri_parsed.path, query_escaped).body
  end
end
 
puts http_request('POST', 'http://posporpor', {:hoge => '20537'})
=end






=begin
# rubyでenum風
module Status
  REQUEST = 1
  APPROVED = 2
  REJECTED = 3
  
  def self.all
    self.constants.map{|name| self.const_get(name) }
  end
end

STATUS_NAME = {
  Status::REQUEST => 'requesting...',
  Status::APPROVED => 'approve',
  Status::REJECTED => 'reject'
}

puts status = Status::REQUEST
puts STATUS_NAME[status]
puts Status.constants
puts Status.all
=end


=begin
# __FILE__だとファイル名も含まれるのでこうする
puts __FILE__
puts Dir.pwd
puts File.expand_path("../README", __FILE__)
=end


=begin
# 自分自身のメソッドを知る
class Object
  def current_method
    caller.first.scan(/`(.*)'/).to_s
  end
end

def metho
  current_method
end

puts metho
=end





=begin
# 自分自身のクラス名を知る
class Mine
  def name
    self.class.name
  end
end

puts Mine.new.name
=end





=begin
# rssチェッカー
require 'open-uri'
require 'rss'

rsslists  = [
  "http://releasepress.jp/feed",
  "http://pr.yahoo.co.jp/release/rss/rss.xml",
  "http://www.jaxa.jp/rss/press_j.rdf",
  "http://prtimes.jp/index.rdf",
]

# テスト用
rsslists  = ["http://releasepress.jp/feed"]

feeds = []
rsslists.each { |rssurl| 
  rss = open(rssurl){ |file| RSS::Parser.parse(file.read) }
  rss.items.each_with_index{|item,i| 
    break if i >= 20
    
    # タイトルを1行にする
    feeds.push(item.title.gsub(/(\r\n|\r|\n)/, "") + "\n" + item.link + "\n" + ">>\n" + item.description[0,400] + "\n<<")
  }
}

#@pressentry = feeds[rand(feeds.size)]
puts @pressentry = feeds[rand(feeds.size)]
=end



=begin
# Botロガー作成
require "./botlogger"
Botlogger.log(File.basename($0))
=end


=begin
# 自分自身のファイル名
puts File.basename($0)
=end

=begin
# ログローテーションテスト
require "logger"

log = Logger.new("log.txt",1, 1 * 1024 * 1024)
log.formatter= proc do |s,d,p,m|
  "#{s[0]},#{d.strftime('%Y/%m/%d %H:%M:%S') } #{m.to_s}\n"
end
log.info("InfoLog")
=end



=begin
# propertiesをcliからデコードするワンライナー
# ruby -pne "$_.scan(/(\\u[\w\d]{4})/).each{|utf|$_.sub!(utf[0],(utf[0][2,4]).to_i(16).chr('UTF-8'))}" app.properties
=end


=begin
# 長文を分割するワンライナー
ruby -pne "$_.split('、').each{|s|File::open('tmp','a').write(s.to_s+\"\n\")}" 01.txt
=end



=begin
# アセットパイプラインのプリコンパイル
rake assets:precompile RAILS_ENV=production
=end




=begin
# arelを使ったOR条件
if params[:hoge_id]||params[:hoge_name]||params[:foo_title]||params[:foo_id]
  arel = BaaModel.arel_table
  arel_where = arel[:hoge_name].matches( params[:hoge_name] == "" ? "" : "%#{params[:hoge_name]}%" )
    .or(arel[:hoge_id].eq(params[:hoge_id]))
    .or(arel[:foo_title].matches( params[:foo_title] == "" ? "" :"%#{params[:foo_title]}%" ))
    .or(arel[:foo_id].eq(params[:foo_id]))
  @search_result = BaaModel.where(arel_where) # "20178508"
end
=end



=begin
# railsの検証と本番の切り替え
case ENV['RAILS_ENV']
  when "development"
    #開発環境
  when "production"
    #本番環境
  when "test"
    #テスト環境
end
=end


=begin
# memcacheテスト
require "memcache"
memcache = MemCache.new("localhost:11211")

puts memcache.set "keyone","itiiti"
puts memcache.get "keyone"
puts memcache.set "keytwo","nini"
puts memcache.get "keytwo"

# 構造化データ
require "json"
tmpjson = {:id => 1, :user => "shin", :time => Time.now, :body => "hello redmemcis!"}
puts memcache.set "tj", tmpjson.to_json
puts JSON.parse(memcache.get("tj"))
=end



=begin
# jibugen
def conjunction
  res = case rand(100)
    when 0..1
      "が"
    when 2..4
      "と"
    when 5..7
      "を"
    when 8..9
      ""
    else
      "の"
  end
  return res
end

def getRandomOneline(path)
  filelinecount = File.open(path, "r:utf-8").read.count("\n") + 1
  oneline = File.open(path).readlines[rand(filelinecount)].chomp
  
  return oneline
end


def gen(word = "")
  word += ""
  word += conjunction unless word.size == 0
  word += getRandomOneline("jiburi.txt")
  
  case rand(100)
    when 0..15
      word = gen(word)
    else
      word += conjunction unless word.size == 0
      word += getRandomOneline("jiburi.txt")
      return word
  end
end

#puts gen
puts conjunction
=end



=begin
# xmlの取得
require "net/http"
require 'rexml/document'

uri = ""

parced_uri = URI.parse(uri)

res = Net::HTTP.get_response(parced_uri)
body = res.body if res.is_a?(Net::HTTPSuccess)

xml = REXML::Document.new(body)
hash = Hash.new
xml.elements.each("response/data/id"){|id|
  hash[id.text] = id.attributes["score"]
}
p hash
=end

=begin
# 時間で分岐
case Time.now.hour
  when (4..6),16
    puts true
end
=end

=begin
# メソッド拡張
class String
  def kkk
    puts self.upcase
  end
end

"asdf".kkk
=end


=begin
# 確率制御 その2
a=0
b=0
10000.times do
  i = rand(100)
  case rand(100)
    when 0..98
      a+=1
    when 99..99
      b+=1
  end
end
p a
p b
=end


=begin
require 'time'
require 'benchmark'

Benchmark.bm(10) do |bm|
  date = DateTime.parse('2012-10-01')
  date_min = DateTime.parse('2012-01-01')
  date_max = DateTime.parse('2012-12-31')
  bm.report('between?') do
    date.between?(date_min, date_max)
  end
end

Benchmark.bm(10) do |bm|
  dates = (DateTime.parse('2012-01-01')..DateTime.parse('2012-12-31'))
  date = DateTime.parse('2012-10-01')
  bm.report('cover?') do
    dates.cover?(date)
  end
end

Benchmark.bm(10) do |bm|
  dates = (DateTime.parse('2012-01-01')..DateTime.parse('2012-12-31'))
  date = DateTime.parse('2012-10-01')
  bm.report('include?') do
    dates.include?(date)
  end
end
=end




=begin
# DateTime
require "date"
#require "time"でもいいっぽい

a = DateTime.new(1993, 2, 24, 12, 30, 45)
b = DateTime.parse('1993-02-24T12:30:45')
b += 10
b - a            #=> 10/1
b.year           #=> 1993
b.strftime('%a') #=> "Sat"

yesterday = DateTime.now - 1
=end



=begin
# 確率制御
a=0
b=0
10000.times do
  i = rand(100)
  case
    when i.between?(0,98)
      a+=1
    when i.between?(99,99)
      b+=1
  end
end
p a
p b
=end


=begin
# rackのreqとres
require "rack"
require "rack/builder"
require 'rack/request'
require 'rack/response'

module Rerack
  extend self
  
  def call(env)
    p env
    req = Rack::Request.new(env)
    
    body = case req.request_method
      when 'GET'
        '<html><body><form method="POST"><input type="submit" value="submi" /></form></body></html>'
      when 'POST'
        '<html><body>kjsldf</body></html>'
    end
    
    res = Rack::Response.new { |r|
      r.status = 200
      r['Content-Type'] = 'text/html;charset=utf-8'
      r.write body
    }
    res.finish
  end
  
end

# Builderの利用
app = Rack::Builder.new {
  run Rerack
}

Rack::Handler::Thin.run app
=end



=begin
# 再度rack
require "rack"

module Rerack
  extend self
  
  def call(env)
    p env
    case env['REQUEST_METHOD']
      when 'GET'
        [
          200,
          { 'Content-Type' => 'text/html' },
          ['<html><body><form method="POST"><input type="submit" value="submi" /></form></body></html>']
        ]
      when 'POST'
        [
          200,
          { 'Content-Type' => 'text/html' },
          ['<html><body>asfasdf</body></html>']
        ]
    end
  end
  
end

Rack::Handler::Thin.run Rerack
=end




=begin
# beep
require 'Win32API'
d = Win32API.new('kernel32', 'Beep', %w(i i), 'i')
d.call(262, 500)
=end



=begin
require 'win32ole'
require 'win32/sound'
include Win32

ni = WIN32OLE.new('TOSCSRX.TOSCSRXCtrl.1')

e = WIN32OLE_EVENT.new(ni)
f = WIN32OLE_EVENT.new(ni)
g = WIN32OLE_EVENT.new(ni)
h = WIN32OLE_EVENT.new(ni)

e.on_event("Interference"){|a|p "1234Inter" + a.to_s}
f.on_event("Recognized"){|a|p "234Recog" + a.Name + "::" + a.Voice}
g.on_event("UtteranceBegin"){|a|p "33434UttBeg"}
h.on_event("UtteranceEnd"){|a|p "16767UttEnd"}

WIN32OLE_EVENT.message_loop
#ni.ShowIndicator

ni.Activate(2,0)
filename = "posisi.wav"

Win32::Sound.play( filename )
sleep 1
ni.Deactivate(2)

WIN32OLE_EVENT.message_loop
=end



=begin
# waveの扱い
File.open("posisi.wav"){|file|
  file.binmode
  puts riff = file.read(4)
  data_size = file.read(4).unpack('V')[0]
  puts "#{data_size} (bytes)"
  puts wave = file.read(4)
  
  if riff != 'RIFF' or wave != 'WAVE'
    puts 'not wave file'
    exit 1
  end
  
  while !file.eof?
    id = file.read(4)
    chunk_size = file.read(4).unpack('V')[0]
    puts "chunk id: #{id}, size: #{chunk_size}"
    if id == 'fmt '
      format_id = file.read(2)[0].to_i
      puts "フォーマットID: #{format_id}"
      channel_num = file.read(2)[0]
      puts "チャンネル数: #{channel_num}"
      hz = file.read(4).unpack('V').join.to_i
      puts "サンプリングレート #{hz} (hz)"
      byte_per_sec = file.read(4).unpack('V').join.to_i
      puts "byte per sec #{byte_per_sec}"
      block_size = file.read(2)[0].to_i
      puts "ブロックサイズ #{block_size}"
      bit_per_sample = file.read(2)[0].to_i
      puts "bit per sample #{bit_per_sample}"
    else
      data = file.read(chunk_size) # 音が入っている部分
    end
  end
}
=end





=begin
# win32-soundの利用
require 'win32ole'
require 'Win32API'

filename = "posisi.wav"

require 'win32/sound'
Win32::Sound.play( filename )

#api=Win32API.new('winmm','waveOutSetVolume','PL','I')
#api.call(-1,left*(16**4)+right)
#OLE.ReadFromFile
=end




=begin
# 認識
require 'win32ole'

ni = WIN32OLE.new('TOSCSRX.TOSCSRXCtrl.1')

e = WIN32OLE_EVENT.new(ni)
e.on_event("Interference"){|a|p "1234Inter" + a.to_s}
e.on_event("Recognized"){|a|p "234Recog" + a.Name + a.Voice}
e.on_event("UtteranceBegin"){|a|p "33434UttBeg"}
e.on_event("UtteranceEnd"){|a|p "16767UttEnd"}

WIN32OLE_EVENT.message_loop

ni.Activate(2,0)
ni.Deactivate(2)

WIN32OLE_EVENT.message_loop

# ruby -r win32ole -e "ie = WIN32OLE.new('TOSSRX.TOSSRXCtrl.1');puts ie.ole_methods;"
=end




=begin
# wave出力
require 'win32ole'

ts = WIN32OLE.new('TOSTTSX.TOSTTSXCtrl.1')
ts.WriteToWaveFile("filefile.wav", "testest")
=end



=begin
# コンポーネントの調べ方
require 'win32ole'

ie = WIN32OLE.new('TOSTTSX.TOSTTSXCtrl.1')
puts  ie.ole_obj_help.to_s
method = ie.ole_method_help('Speak')
puts method.return_type
method.params.each do |param|
  str = ""
  str.concat "[in] " if param.input?
  str.concat "[out] " if param.output?
  str.concat "[optional] " if param.optional?
  str.concat "[retval] " if param.retval?
  str.concat param.name
  str.concat " = #{param.default}" if param.default
  str.concat " As #{param.ole_type}"
  puts str
end

# ruby -rwin32ole -e 'puts WIN32OLE_TYPE.progids'
# ruby -r win32ole -e "ie = WIN32OLE.new('InternetExplorer.Application');puts ie.ole_methods;"
=end


=begin
# IEの制御
require 'win32ole'

ie = WIN32OLE.new('InternetExplorer.Application')
ie.Navigate("http://www.google.co.jp/")
ie.Visible = true
while ie.busy
  sleep 1
end
q = ie.document.all.Item("q")
q.Value = "ruby"
btnG = ie.document.all.Item("btnG")
btnG.click()
=end


=begin
# パターン作成
def rundom(i)
  (("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a).shuffle[0..i].join
end

# 配列格納
arr = []
1000000.times do
  arr.push(rundom(7))
end
puts arr.size
puts arr.uniq.size
=end


=begin
# sinatra自動リロード
require 'sinatra'
require 'slim'
require "sinatra/reloader" if development?

template :layout do
<<EOF
html
  body
    == yield
EOF
end

template :index do
<<EOF
/ asdflkj
.asdf asdf
a[href="dsf"] asdfdddf
.sdf sdfd
tr
  td df
  td sdf
  td = @val
form(action='/' method='POST')
  div.button
    input type="hidden" name="para" value="jiji"
    input type="submit" value="sub" 

EOF
end


get '/' do
  @val = "af"
  slim :index
end

post '/' do
  @val = params[:para]
  slim :index
end
=end




=begin
# daemon
require "daemons"
Daemons.run('./daemon.rb')
=end

=begin
# activeMQ
require "stomp"

client = Stomp::Client.new("user", "pass", "localhost", 61613)
client.publish("/queue/mine", "hello world!")
client.subscribe("/queue/mine") do |msg|
  p msg.body
end
=end



=begin
# wshとoleの利用
require 'win32ole'

def show(msg, title)
  wsh = WIN32OLE.new('WScript.Shell')
  wsh.Popup(msg, 0, title, 0 + 64 + 0x40000)
end

show("Hell", "Hell's title")
=end



=begin
require 'mail'

mail = Mail.new
mail.from = ''#不使用
mail.to = ''
mail.subject = 'testest'
mail.body = 'Theimgetmpa body.'


#mail.charset = 'ISO-2022-JP'
#mail.subject = NKF.nkf('-M', '日本語のtitle')
#mail.body = NKF.nkf('-j', '日本語の本文')

mail.add_file 'as.jpg'


mail.delivery_method :smtp, { 
  address:   'smtp.gmail.com',
  port:      587,
  domain:    'example',
  user_name: '',
  password:  "",
  authentication: 'plain',
  enable_starttls_auto: true
}
mail.deliver!
=end




=begin
# EC2の立ち上げ立ち下げ
require "aws"

AWS.config(
  :access_key_id => 'YOUR_ACCESS_KEY_ID',
  :secret_access_key => 'YOUR_SECRET_ACCESS_KEY')

# ec2 = AWS::EC2.new

ec2 = AWS::EC2.new(
  :access_key_id => 'YOUR_ACCESS_KEY_ID',
  :secret_access_key => 'YOUR_SECRET_ACCESS_KEY')

# インスタンス作成
ec2.instances.create(:image_id => "ami-8c1fece5")

# インスタンスIDの確認
i = ec2.instances["i-12345678"]
i.exists?

# インスタンスの状態リスト取得
ec2.instances.inject({}) { |m, i| m[i.id] = i.status; m }
# => { "i-12345678" => :running, "i-87654321" => :shutting_down 


# Elastic IPs
instance = ec2.instances['i-12345678']
instance.ip_address

#ip = ec2.elastic_ips.allocate
#ip.ip_address

# regions
ec2.regions.map(&:name)

AWS::EC2.new(:region => "us-west-1")


# Availability Zones
ec2.availability_zones.map(&:name)

# Images
ec2.images.with_owner("amazon").map(&:name)


# sdk2
require 'aws-sdk-core'

Aws.config = { access_key_id: '...', secret_access_key: '...', region: 'us-west-2' }

s3 = Aws::S3.new
s3 = Aws.s3

resp = s3.list_buckets
puts resp.buckets.map(&:name)

resp = s3.list_objects(bucket: 'aws-sdk-core', max_keys: 2)
resp.contents.each do |object|
  puts "#{object.key} => #{object.etag}"
end
=end


=begin
# Hash#mapをHashに入れる
Hash[ 5.times.map{|a|[a,9]} ]
5.times.inject( {} ){ |a,b| a.store(b,9);a }
=end


=begin
# mutex
require 'thread'

m = Mutex.new
ts = []
3.times { |j|
  ts << Thread.start {
    m.synchronize { # ブロック内の処理が同期実行される。
      5.times { |i|
        puts "thread-" << j.to_s << " : " << i.to_s
        sleep rand * 0.1
      }
    }
  }
}

ts.each {|t| t.join }
=end


=begin
# シリアライズ
require 'benchmark'
require 'json'
require 'yaml'
require 'oj'
require 'msgpack'
# require 'rblineprof' 入らなかった

TIMES = 100000

def sample
  ["hoge", rand, rand(100), rand(10), rand(10)]
end

Benchmark.bm do |x|
  x.report("marshal") do
    TIMES.times do
      arr = sample
      m = Marshal.dump(arr)
      a = Marshal.load(m)
    end
  end

  x.report("json") do
    TIMES.times do
      arr = sample
      m = arr.to_json
      a = JSON.parse(m)
    end
  end

  x.report("oj") do
    TIMES.times do
      arr = sample
      m = Oj.dump(arr)
      a = Oj.load(m)
    end
  end

  x.report("yaml") do
    TIMES.times do
      arr = sample
      m = YAML.dump(arr)
      a = YAML.load(m)
    end
  end

  x.report("msgpack") do
    TIMES.times do
      arr = sample
      m = arr.to_msgpack
      a = MessagePack.unpack(m)
    end
  end
end
=end




=begin
# ログ出力
require "logger"

# ログ出力インスタンスを取得 (*) 標準出力を行う
log = Logger.new(STDOUT)

# プログラム名を取得
log.progname = "TEST_PROG"

# ログ出力
log.debug("DebugLog")
log.info("InfoLog")
log.warn("WarnLog")

# ログレベルを設定する (*) INFOレベル以上を出力
log.level = Logger::INFO

# ログ出力
log.debug("DebugLog");
log.info("InfoLog");
log.warn("WarnLog");

# 新しいログ出力インスタンスを生成 (*) ログファイルに吐く
log = Logger.new("log.txt");

# ログ出力
value = "VALUE"
log.debug("DebugLog #{value}");
log.debug("AAAAA"){"BBBB"}
log.info("InfoLog");
log.warn("WarnLog");
=end



=begin
# post送信のパラメータ生成とAPI連携
require 'digest/hmac'
require 'json'
require 'net/http'
require 'uri'
require 'base64'
require 'rexml/document'

uri = URI.parse("")

nowtime = Time.now.strftime("%Y%m%d%H%M%S")
paramhash = {
  "timestamp" => nowtime
}
paramhash = Hash[paramhash.sort]
paramhash["signature"] = Base64.strict_encode64(Digest::HMAC.digest(URI.encode_www_form(paramhash), 'sign', Digest::SHA1))

request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/x-www-form-urlencoded'})
request.body = URI.encode_www_form(paramhash)

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

#http.set_debug_output $stderr

response = nil
http.start do |h|
  response = h.request(request)
end

tokenxml = REXML::Document.new(response.body)
=end



=begin
# google api
require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'

client_secrets = Google::APIClient::ClientSecrets.load
client = Google::APIClient.new(
  :application_name => 'Example Ruby application',
  :application_version => '1.0.0',
)
client.authorization.client_id = client_secrets.client_id
client.authorization.client_secret = client_secrets.client_secret
client.authorization.redirect_uri = client_secrets.redirect_uris.first
client.authorization.grant_type = "authorization_code"
client.authorization.code = "4/hkRL1kXFneKFIE2as0O5J9Pd8dwP.ksB7soMdTQoQgrKXntQAax0kvFS0hQI"
client.authorization.access_token = "ya29.1.AADtN_VR7Sjymuvv5cT7sGf-uK5qno6wnFlD8u1R3qRGMd-O_5dnRErSxMyUzOY"
client.authorization.expires_in = "3600"
client.authorization.refresh_token = "1/biPiPItefdlFwIucWicQXLAS7wy0zH8SjlWbx0OyvgY"
#p client

#code取得
#https://accounts.google.com/o/oauth2/auth?client_id=249746177458-9j8vjpn0l1bmea1v79pn1qrp83cej2oa.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%2Foauth2callback&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Ftasks&response_type=code
#http://localhost/oauth2callback?code=4/_TbOueEnA9fCj5Syvr1vEQMtMhfe.kpqS30fPh9MQgrKXntQAax2oZaishQI

#https://accounts.google.com/o/oauth2/auth?client_id=249746177458-thq6je63map68fbkrr2ai5q54g04m9o4.apps.googleusercontent.com&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Ftasks&response_type=code
#4/ERuYzhhWDmNCN8xARPc7lJUdS1lD.wk2levn3CrsSgrKXntQAax0ymESthQI

#client.authorization.fetch_access_token!
#client.authorization.auto_refleash_token

tasks = client.discovered_api('tasks')
result = client.execute(:api_method => tasks.tasklists.list)
#p result.data

result2 = client.execute(
  :api_method => tasks.tasks.list,
  :parameters => {"tasklist" => result.data.items[0].id}
)
result2.data.items.each{|a|puts a.title}
=end


=begin
# リダイレクトの場合location確認
require "net/http"
response = Net::HTTP.get_response(URI.parse('http://yahoo.co.jp'))
puts response["location"]
response.each{|a,b|puts a+" : "+b}
=end


=begin
# 文字列 ランダム
def cacha
  ["タ","チ","ツ","テ","ト","カ","キ","ク","ケ","コ"].shuffle[0] + ["ァ","ィ","ゥ","ェ","ォ","ャ","ュ","ョ",""].shuffle[0] + "ッ" + ["タ","チ","ツ","テ","ト","カ","キ","ク","ケ","コ"].shuffle[0] + ["ァ","ィ","ゥ","ェ","ォ","ャ","ュ","ョ"].shuffle[0]
end

puts cacha + cacha
=end

=begin
# tsv2json
require "json"
head = ARGF.first.split("\t")
head.shift
line = nil
ARGF.each{|l|
  llist = l.strip.split("\t")
  id = llist.shift
  value = head.zip(llist).inject({}){|h,x| h[x[0]]=x[1];h}
  line = Hash[id , value]
  break
}
=end


=begin
# 上記のtsvをcouchbaseにインポート
client = Couchbase.connect(:bucket => "ticket", :hostname => "192.168.80.64", :username => 'suzuki', :password => 'suzuki')
list.each{|line|
  begin
    client.set(line)
  rescue => ex
    p ex
  end
}
client.disconnect
=end


=begin
module Operator
  Plus = ->x,y{x+y}
  Minus = ->x,y{x-y}
  Multiplication = ->x,y{x*y}
  Division = ->x,y{x/y}
end

def Matchstick(i)
  case i
    when 0
      return 6
    when 1
      return 2
    when 2
      return 5
    when 3
      return 5
    when 4
      return 4
    when 5
      return 5
    when 6
      return 6
    when 7
      return 4
    when 8
      return 7
    when 9
      return 6
  end
end

def Kalk(x, y, operator)
  x = Matchstick(x)
  y = Matchstick(y)
  operator.call(x,y).abs
end

puts Kalk(2, 4, Operator::Plus)
puts Kalk(2, 4, Operator::Minus)
puts Kalk(4, 2, Operator::Minus)
puts Kalk(6, 3, Operator::Division)
=end



=begin
catch :label do
  catch :label1 do
    puts "This will print"
  throw :label
    puts "This won't print"
  end
  puts "Neither will this print"
end
=end


=begin
# Ruby での throw と catch
catch :label do
  puts "This will print"
throw :label
  puts "This will not print"
end
=end


=begin
# クラスのプライベート・メソッドにアクセスする
class SendTest
  private
  def hello
    puts "Saying Hello privately"
  end
end

y = SendTest.new

#y.hello
y.send(:hello)
=end

=begin
# send メソッドを使用してルーチンに引数を渡す
class Test
  def method1(s, y)
    puts "S: #{s} Y: #{y}"
  end
end
t = Test.new
t.send(:method1, 23, 12)
=end

=begin
# method_missing 
class Test
  def method_missing(method, *args)
    puts "Method: #{method} Args: (#{args.join(', ')})"
  end
end

t = Test.new
t.f(23)
=end

=begin
class SelfTest4
  def method1
    self.method2
  end
  
  def method3
    method2
  end
  
  private
  def method2
    puts "Inside private method"
  end
end

y = SelfTest4.new
#y.method1
y.method3
=end

=begin
class MyTest
  class << self 
    def test
      puts "This is a class static method"
    end
  end
end

MyTest.test   # works fine 
=end

=begin
class TestMe
  def TestMe.test
    puts "Yet another static member function"
  end
end

TestMe.test  # works fine
=end


=begin
class SelfTest
  def self.test
    puts "Hello World with self!"
  end
end

class SelfTest2
  def test
    puts "This is not a class static method"
  end
end

SelfTest.test
SelfTest2.test
=end

=begin
# シングルトンメソッド
class Human
end

y = Human.new
def y.paint
  puts "Can paint"
end

y.paint

z = Human.new
#z.paint
class << y
  def sing
  puts "Can sing"
  end
end
y.sing
puts y.singleton_methods
=end

=begin
module Status
  REQUEST = 1
  APPROVED = 2
  REJECTED = 3
end

STATUS_NAME = {
  Status::REQUEST => 'リクエスト中',
  Status::APPROVED => '承認',
  Status::REJECTED => '拒否'
}

def status_text
  status = Status::REQUEST
  STATUS_NAME[self.status]
end
=end

=begin
# 川クラス
class River
  def initialize()
    @left = Place.new(3, 3)
    @right = Place.new(0, 0)
    @left.moveBoat()
    status_print(@left, @right)
  end
  
  # 移動
  def move(s, t)
    if (@left.haveBoat() == true)
      @left.setS(@left.getS - s)
      @left.setT(@left.getT - t)
      @right.setS(@right.getS + s)
      @right.setT(@right.getT + t)
    else
      @left.setS(@left.getS + s)
      @left.setT(@left.getT + t)
      @right.setS(@right.getS - s)
      @right.setT(@right.getT - t)
    end
    
    @left.moveBoat()
    @right.moveBoat()
    check_state(@left)
    check_state(@right)
    status_print(@left, @right)
  end
end

# 場所クラス
class Place
  def initialize(x, y)
    @s = x
    @t = y
    @b = false
  end
  
  def getS()
    return @s
  end
  
  def setS(i)
    @s = i
  end
  
  def getT()
    return @t
  end
  
  def setT(i)
    @t = i
  end
  
  def haveBoat()
    return @b
  end
  
  def moveBoat()
    @b = !@b
  end
end

# 状況判定
def check_state(place)
  s = place.getS
  t = place.getT
  
  if (s !=0 && t !=0)
    return (s >= t)
  else
    return true
  end
end

# 文字出力
def status_print(left, right)
  result = ""
  result += "S" * left.getS
  result += "T" * left.getT
  result += "/"
  result += "S" * right.getS
  result += "T" * right.getT
  
  puts result
end



river = River.new
river.move(0,2)
river.move(0,1)
river.move(0,2)
river.move(0,1)
river.move(2,0)
river.move(1,1)
river.move(2,0)
river.move(0,1)
river.move(0,2)
river.move(0,1)
river.move(0,2)
=end


=begin
# 並列で画像取得
require 'digest/md5'
require 'open-uri'
require 'thread'

urls = [
    'http://farm4.staticflickr.com/3052/3086132328_e2041be795.jpg',
    'http://farm7.staticflickr.com/6053/6312937936_cebaf2feb9.jpg',
    'http://farm1.staticflickr.com/54/131841577_0e67642c02.jpg',
    'http://farm3.staticflickr.com/2293/2266151759_058e732577.jpg',
    nil
]

q = Queue.new
urls.each { |url| q.push(url) }

max_thread = 2 # 最大スレッド数

# max_threadで指定した数だけスレッドを開始
Array.new(max_thread) do |i|
  Thread.new { # スレッドを作成
    begin
      # 最後のnilになったらfalseになって終了
      while url = q.pop(true)
        puts "start download: #{url}"
        img = open(url) rescue next
        img.close
        file_path = "./#{Digest::MD5.hexdigest(url)}.jpg"
        File.rename(img.path, file_path)
        puts "end download: #{url}"
      end
      q.push nil # 最後を表すnilを別スレッドのために残しておく
    end
  }
end.each(&:join)
puts "finish process"
=end


=begin
# parallelの使用
require "parallel"

Parallel.each(urilist, in_threads: 10) {|url|
  puts "start download: #{url}"
  File::open(resultfile, "a").write(Checklink.new().checkuri(url))
  puts "end download: #{url}"
}
=end



=begin
# rubyでassert
moge = "moge"
raise "assert" unless moge == "moge" 

a = 10
b = 40
raise "assert" unless 30 == a + b, '足したら30のはず'
=end

=begin
# MariaDB
require "mysql"
db = Mysql.connect("localhost", "root", "12121212", "tmp")
db.query("create temporary table tmp (one int, two int)")
db.query("insert into tmp(one, two) values(1,2)")
db.query("insert into tmp(one, two) values(10,20)")

res = db.query("select * from tmp")

res.each {|r|
  puts r
}
=end

=begin
require "pg"

db = PG::connect(:host => "localhost", :user => "ka-suzuki", :password => "a", :dbname => "tmp")

db.exec("create temporary table tmp (one int, two int)")
db.exec("insert into tmp(one, two) values(1,2)")
db.exec("insert into tmp(one, two) values(10,20)")

res = db.exec("select * from tmp")

res.each {|r|
  puts r
}
=end

=begin
require "pg"

conn = nil
begin
  # コネクションの取得
  conn = PGconn.connect(:host => "localhost", :user => "ka-suzuki", :password => "a", :dbname => "tmp")
  
  # テーブルの作成
  sql = "create temp table t_user(id integer not null, name text, primary key (id))"
  res = conn.exec(sql)
  
  # データの登録
  data = ["予定表", "?", "?", "ﾊﾝｶｸ"]
  
  index = 1
  data.each do |name|
    sql = "insert into t_user (id, name) values (" + index.to_s + ", '" + name + "')"
    res = conn.exec(sql)
    index = index + 1
  end
  
  # データ取得
  sql = "select id, name from t_user"
  res = conn.exec(sql)
  
  res.each do |row|
    puts row["id"].to_s + ":" + row["name"]
  end
  
  # テーブル削除
  sql = "drop table t_user"
  res = conn.exec(sql)
ensure
  if nil != conn
    conn.close
  end
end
=end



=begin
require "pg"

# コネクション
db = PG::connect(:host => "localhost", :user => "ka-suzuki", :password => "a", :dbname => "tmp")
=end



=begin
# ruby/tk
require "tk"

button = TkButton.new
button.text = 'exit'
button.command = proc { exit }
button.pack

Tk.mainloop
=end


=begin
# ActiveSupport::Concernを使った例
require "active_support"
module Mod
  # self.includedの代わり
  extend ActiveSupport::Concern
  
  # クラスメソッド用(名前に注意)
  module ClassMethods
    def ope2(x)
      x + 10
    end
  end
  
  # インスタンスメソッド用
  def ope(x)
    x * x
  end
end

class MixinClass
  include Mod
end

#puts MixinClass.ope(3)
puts MixinClass.ope2(3)

puts MixinClass.new.ope(4)
#puts MixinClass.new.ope2(4)
=end


=begin
# include時に両方に追加する
module Mod
  def self.included(base)
    base.extend(ClaMe)
  end
  
  # クラスメソッド用
  module ClaMe
    def ope2(x)
      x + 10
    end
  end
  
  # インスタンスメソッド用
  def ope(x)
    x * x
  end
end

class MixinClass
  include Mod
end

#puts MixinClass.ope(3)
puts MixinClass.ope2(3)

puts MixinClass.new.ope(4)
#puts MixinClass.new.ope2(4)
=end


=begin
# module練習7
# 特異メソッドを作る場合の構文
#Mod = Class.new
#class << Mod # class << クラス名
class << (Mod = Class.new) # class << クラス名
  def ope(x)
    x * x
  end
end

puts Mod.ope(3)
=end

=begin
# module練習6
# 特異メソッドのみのクラス
class Mod
  # 匿名モジュールを作成してextend
  extend Module.new {
    def ope(x)
      x * x
    end
  }
end

puts Mod.ope(6)
=end

=begin
# module練習5
# extendの引数にはモジュールしか指定することができない
# class Mod # wrong argument type Classになる
module Mod
  #def self.ope(x)
  extend self
  def ope(x)
    x * x
  end
end

puts Mod.ope(2)
=end


=begin
# module練習4
module Mod
  def ope(x)
    x * x
  end
end

class MixinClass
  #include Mod # インスタンスメソッド
  extend Mod # 特異メソッド
end

#puts MixinClass.new.ope(3) # extendだとエラー
puts MixinClass.ope(5) # includeだとエラー

# インスタンスに追加するにはextendメソッドで
m =  MixinClass.new.extend Mod
puts m.ope(7)
=end

=begin
# module練習3
module Mod
  def ope(x)
    x * x
  end
  
  # モジュールを関数のように実行
  module_function:ope
end

#include Mod
puts Mod.ope(4)
include Mod
puts ope(5)
=end


=begin
# module練習2
module Mod
  def ope(x)
    x * x
  end
end

class MixinClass ;end
#end

m1 = MixinClass.new
m2 = MixinClass.new

# オブジェクト(インスタンス)にだけモジュール追加
m1.extend Mod

puts m1.ope(2)
puts m2.ope(3) # エラー
=end


=begin
# module練習1
module Mod
  def ope(x)
    x * x
  end
end

class MixinClass
  # クラスにモジュールを追加
  include Mod
end

m = MixinClass.new
puts m.ope(2)
=end



=begin
# for文
ar=[1,4,6]
for i in 0..(ar.size) do
  puts ar[i]
end
=end

=begin
# ラムダ式と並列処理練習
tl = []
lam = -> i {
  begin
    threadtest = Thread.new &-> {
      puts "start"
      sleep 3
    }
    tl.push(threadtest)
  rescue => ex
    p ex
  end
}

starttime = Time.now

threadtest = nil
2.times &lam
tl.each &-> th { th.join }

endtime = Time.now
puts endtime - starttime
=end




=begin
# 1ノード16G限界試験 (75,000,000レコード)=15Gの想定
require 'couchbase'
starttime = Time.now
client = Couchbase.connect(:bucket => "bigbucket", :hostname => "localhost", :username => 'suzuki', :password => 'suzuki')
75000000.times{
  begin
    json = {"bigdatatest" + rand(10000000000).to_s => {"hogeid"=>rand(10000000000).to_s, "fooid"=>rand(10000000000).to_s, "affiliateid"=>rand(10000000000).to_s, "other"=>rand(10000000000).to_s}}
    client.set(json)
    #client.get("stressTest" + rand(1000000000).to_s)
  rescue => ex
    p ex
  end
}
client.disconnect
endtime = Time.now
puts endtime - starttime
=end


=begin
def insert(client)
  starttime = Time.now
  puts "start" + client.hostname
  100.times{
    begin
      json = {"bigdatatest" + rand(10000000000).to_s => {"hogeid"=>rand(10000000000).to_s, "fooid"=>rand(10000000000).to_s, "affiliateid"=>rand(10000000000).to_s, "other"=>rand(10000000000).to_s}}
      client.set(json)
    rescue => ex
      p ex
    end
  }
  endtime = Time.now
  puts endtime - starttime
end

starttime = Time.now
cli1 = Couchbase.connect(:bucket => "bigbucket", :hostname => "192.168.80.64", :username => 'suzuki', :password => 'suzuki')
cli2 = Couchbase.connect(:bucket => "bigbucket", :hostname => "192.168.80.65", :username => 'suzuki', :password => 'suzuki')
threadtest = nil
tl = []
10.times{
  begin
    threadtest = Thread.new{insert(cli1)}
    threadtest = Thread.new{insert(cli2)}
    tl.push(threadtest)
  rescue => ex
    p ex
  end
}
#threadtest.join
tl.each{|th|
  th.join
}
cli1.disconnect
cli2.disconnect
endtime = Time.now
puts endtime - starttime
=end

=begin
# couchbase APIの速度試験
require "json"
require "net/http"

def api(u)
  st = Time.now
  res = Net::HTTP.get_response(URI.parse(u))
  p JSON.parse(res.body)["total_rows"]
  et = Time.now
  puts et - st
end

uri = "http://192.168.80.64:8092/bigbucket/_design/view/_view/view/"
threadtest = nil
starttime = Time.now
1.times{
  begin
    threadtest = Thread.new{api(uri)}
  end
}
threadtest.join
endtime = Time.now
puts endtime - starttime
=end


=begin
# Couchbase 複数スレッドの速度試験
require 'couchbase'

# スレッドへ引数を渡す
def find(client)
  st = Time.now
  client.design_docs["test"].heavytestr.each{|v|v}
  #if (client.design_docs["test"].find.count != 1)
  #  puts "nothing!"
  #end
  et = Time.now
  puts et - st
end

starttime = Time.now
cli = Couchbase.connect(:bucket => "njstest", :hostname => "192.168.80.64", :username => 'suzuki', :password => 'suzuki')
threadtest = nil
100.times{
  begin
    threadtest = Thread.new{find(cli)}
  end
}
threadtest.join
cli.disconnect
endtime = Time.now
puts endtime - starttime
=end



=begin
# Couchbase 重いViewの速度試験
require 'couchbase'
starttime = Time.now
client = Couchbase.connect(:bucket => "njstest", :hostname => "192.168.80.64", :username => 'suzuki', :password => 'suzuki')

100.times{
  #client.set("stressTest" + rand(1000000000).to_s,{"arthistid"=>rand(1000000000).to_s})
  #client.get("stressTest" + rand(1000000000).to_s)
  client.design_docs["test"].heavytest.each{}
}
client.disconnect
endtime = Time.now
puts endtime - starttime
=end


=begin
# Couchbase Get Setの速度試験
require 'couchbase'
starttime = Time.now
#client = Couchbase.connect(:bucket => "beer-sample", :hostname => "localhost", :username => 'suzuki', :password => 'suzuki')
client = Couchbase.connect(:bucket => "njstest", :hostname => "192.168.80.64", :username => 'suzuki', :password => 'suzuki')
10000.times{
  #client.set("stressTest" + rand(1000000000).to_s,{"arthistid"=>rand(1000000000).to_s})
  begin
    client.get("stressTest" + rand(1000000000).to_s)
  rescue => ex
    #p ex
  end
}
client.disconnect
endtime = Time.now
puts endtime - starttime
=end


=begin
# try catch
begin
  # 実行する処理
  1 + "aaa"
rescue SyntaxError => ex
  # 例外が発生したときの処理
  puts "rescue!error"
  p ex
rescue => ee
  # 例外が発生したときの処理
  puts "rescue!"
  p ee
else
  # 例外が発生しなかったときに実行される処理
  puts "harmony"
ensure
  # 例外の発生有無に関わらず最後に必ず実行する処理
  puts "must"
end
=end


=begin
starttime = Time.now
10000.times{
  client.set("stressTest",{"arthistid"=>"1234567890"})
}
client.disconnect
endtime = Time.now
puts endtime - starttime
=end



=begin
# 再度正規表現
text="く  　た　 　 び　 れ"

# パターンを網羅できていなかった・・・
if text[/く[\s　]*た[\s　]*び[\s　]*れ/]
  puts true
end
=end

=begin
# jsonをxmlにする
require "nokogiri"
require "json"

hash = JSON.parse("{\"asdf\":\"cccd\",\"aaa\":\"bbb\"}")
xmlObj = Nokogiri::XML::Builder.new { |xml|
  xml.root {
    hash.each{ |k, v|
      eval("xml.#{k} { xml.text v }")
    }
  }
}

puts xmlObj.to_xml
=end

=begin
# csvとjson
require "json"
require "csv"

# csvをjsonにする
p CSV.parse("aaa,bbb,ccc").flatten.to_json

# jsonをcsvにする
JSON.parse("{\"asdf\":\"cccd\",\"aaa\":\"bbb\"}").each do |arr|
  p arr.to_csv
end
=end

=begin
# 文字化けしたapplication.propertiesを読めるようにする
File.readlines("application.properties_org").each do |line|
  #puts line
  #p line.scan(/(\\u[\w\d]{4})/i)
  
  utfs = line.scan(/(\\u[\w\d]{4})/)
  utfs.each{|utf|
    #p (utf[0][2,4]).to_i(16).chr("UTF-8")
    #open("res.txt", "a+").write((utf[0][2,4]).to_i(16).chr("UTF-8"))
    line.sub!(utf[0],(utf[0][2,4]).to_i(16).chr("UTF-8"))
  }
  
  open("application.properties", "a+").write(line)
  #open("res.txt", "a+").write(aa.ord.chr("UTF-8"))
  #open("res.txt", "a+").write("\u30a3")
  #open("res.txt", "a+").write(12354.chr("UTF-8"))
end
=end

=begin
# MD5の計算
require 'digest/md5'
puts Digest::MD5.hexdigest("test")
=end


=begin
# Couchbase SDKの速度試験
require 'couchbase'
starttime = Time.now
#client = Couchbase.connect(:bucket => "beer-sample", :hostname => "localhost", :username => 'suzuki', :password => 'suzuki')
client = Couchbase.connect(:bucket => "beer-sample", :hostname => "192.168.80.64", :username => 'suzuki', :password => 'suzuki')
client.design_docs["beer"].brewery_beers.count
#client.disconnect
endtime = Time.now
puts endtime - starttime

starttime = Time.now
client.design_docs["beer"].brewery_beers.count
endtime = Time.now
client.disconnect
puts endtime - starttime
=end

=begin
# CouchbaseのAPIあれこれ
require "json"
require "net/http"

#uri = "http://localhost:8092/"
uri = "http://localhost:8092/beer-sample/_design/beer/_view/brewery_beers/"
#uri = "http://192.168.80.64:8092/beer-sample/_design/beer/_view/brewery_beers/"
starttime = Time.now
res = Net::HTTP.get_response(URI.parse(uri))
puts JSON.parse(res.body)["rows"][0]["key"][0]
endtime = Time.now
puts endtime - starttime
=end

=begin
# Couchbase Viewサンプル確認
require 'couchbase'
client = Couchbase.connect(:bucket => "testbucket", :username => 'suzuki', :password => 'suzuki')
puts client
ddoc = client.design_docs["ddn"]
puts ddoc
puts ddoc.views
puts ddoc.class
client.disconnect
=end

=begin
# Couchbase接続サンプル確認
require 'couchbase'
client = Couchbase.connect(:bucket => "testbucket", :username => 'suzuki', :password => 'suzuki')
puts client
getid = client.get("testid")
puts getid
puts getid["_id"]
puts getid["_id"] = "nise"
puts getid
client.replace("testid", getid)
getid = client.get("testid")
puts getid
puts getid["_id"]
getid.each{|a|p a}
client.disconnect
=end


=begin
#Compositeパターンの確認
# Component(部品) 
class Entry
  def get_name
  end
  def ls_entry(prefix)
  end
end

# Leaf(葉) 
class FileEntry < Entry
  def initialize(name)
    @name = name
  end
  def get_name
    @name
  end
  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
  end
end

# Composite(合成物) 
class DirEntry < Entry
  def initialize(name)
    @name = name
    @directory = Array.new
  end
  def get_name
    @name
  end
  def add(entry)
    @directory.push(entry)
  end
  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
    @directory.each {|e|
      e.ls_entry(prefix + "/" + @name)
    }
  end
end

root = DirEntry.new("root")
tmp  = DirEntry.new("tmp")
tmp.add(FileEntry.new("passwd"))
tmp.add(FileEntry.new("plist"))
root.add(tmp)
root.ls_entry("")
=end


=begin
# 正規表現で目的の文字列の存在確認
regex = "く  た    び れ"
if regex[/く\s+た\s+び\s+れ/]
  puts "find"
else
  puts "not"
end
=end

=begin
# EventMachineテスト
require "eventmachine"

def randomsleep(ind)
  rand_int = rand 8
  sleep rand_int
  return ind, rand_int
end

puts "Test start"
EM.run {
  puts "EM start"
  
  5.times.each{|i|
    EM.defer {
      puts "defer in" + i.to_s
      p randomsleep i
      puts "defer out" + i.to_s
    }
  }
  
  EM.add_timer(8) { 
    puts "EM.stop now"
    EM.stop
    puts "EM stoped"
  }
  
  puts "EM end"
}
puts "Test compleated"
=end


=begin
# celluloid テスト
# さっぱり・・・
require 'celluloid'

class Counter
  include Celluloid
  attr_reader :count
  
  def initialize
    @count = 0
  end
  
  def increment(n = 1)
    sleep n
    @count += n
  end
end

actor = Counter.new
p actor.count 
p actor.increment 
p actor.async.increment(41) 
p actor.count
=end


=begin
# ファイバーテスト
fiber = Fiber.new {
  n = 0
  loop {
    # yieldの引数が親への戻り値
    Fiber.yield(n)
    n += 1
  }
}

5.times {
puts fiber.resume
}
=end


=begin
# EventMachineでReactorパターン
require "eventmachine"
hosts = ["http://yahoo.com/"]
hosts_size = hosts.size

EM.run {
  hosts.each {|h|
    puts h
    #http = EM::Protocols::HttpClient.request(:host=>h, :port=>80, :request=>"/")
    #http = EM::HttpRequest.new(h).get
    # ダメだった
    http.callback {|data|
      puts data.response
      EM.stop_event_loop if (hosts_size -= 1) <= 0
    }
  }
}
=end


=begin
# 複数のURLから20件のフィードを取得し全件の中からランダムで返却する
require 'open-uri'
require 'rss'

rsslists = []

#rss = open("http://files.value-press.com/rss/index.rdf"){ |file| RSS::Parser.parse(file.read) }
rss = open("http://releasepress.jp/feed"){ |file| RSS::Parser.parse(file.read) }
rss.items.each_with_index{|item,i| 
  break if i >= 20
  # タイトルを1行にする
  rsslists.push(item.title.gsub(/(\r\n|\r|\n)/, "") + "\n" + item.link + "\n" + ">>\n" + item.description[0,300] + "\n<<")
}
puts rsslists.size
puts rsslists[rand(rsslists.size)]
=end

=begin
x = 12345
res = 0
# 自分で書いたやりかた
x.to_s.split("").each{|i|
  res = res + i.to_i
}
puts res

# injectを使ったやりかた
p(x.to_s.scan(/./).inject(0){|i, v| i + v.to_i })
=end


=begin
# couchDB接続テスト
require "couchdb"
server = CouchDB::Server.new("localhost","5984")
database = CouchDB::Database.new server, "mokkai"
design = CouchDB::Design.new database, "design_1"
view = CouchDB::Design::View.new design, "view_1", "function(document) { emit([ document['category'], document['_id'] ]); }"
#design.save
# かなり複雑・・・・
puts view.collection.size
=end

=begin
# Why do we convert the list of symbols to strings and then compare
# against the string value rather than against symbols?

# もともとのやつ
def test_method_names_become_symbols
  symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }
  puts symbols_as_strings.include?("test_method_names_become_symbols")
  puts symbols_as_strings.include?("test_method_names_become_symbols_other")
end
test_method_names_become_symbols

# 比較した瞬間に存在することになってしまう
def test_method_names_become_symbols_not
  symbols_as_strings = Symbol.all_symbols.map { |x| x }
  puts symbols_as_strings.include?(:test_method_names_become_symbols_not)
  puts symbols_as_strings.include?(:test_method_names_become_symbols_not_other)
end
test_method_names_become_symbols_not
=end


=begin
# 複数行テキストの一行目と以降を分ける
linestext = "いちぎょうめ\nそれいこう\naaa\niii"
#puts linestext


# 一行ずつ処理する
title = ""
content = ""
firstflg = true
linestext.each_line {|l|
  if firstflg
    title =  l
    firstflg = false
  else
    content << l
  end
}

puts title
puts content
=end


=begin
# ハッシュを作成する際に引数を渡すとデフォルト値
hash2 = Hash.new("dos")
=end

=begin
def dicegame(grid, count)
  #
  i = 0.0
  count.times {
    d = rand(6)+1
    i = i + d
  }
  
  if (grid <= i)
    $clear = $clear + 1
  else
  end
end

$clear = 0.0
10000.times {
  dicegame(*ARGV[0].to_i, *ARGV[1].to_i)
}
puts $clear / 10000
=end


=begin
# サイコロの平均値
def sai(count)
  i = 0.0
  count.times {
    i = i + rand(6)+1
  }
  puts i / count
end

sai *ARGV[0].to_i
=end

=begin
# Redisテスト

require "redis"
redis = Redis.new(:host => "127.0.0.1")

puts redis.set "tmpkey","tmpvalue"
puts redis.get "tmpkey"
puts redis.set "tmpkeysec","tmpvalueni"
puts redis.get "tmpkeysec"

# 複数キー指定
puts redis.mget "tmpkey","tmpkeysec"

# リスト操作
#puts redis.rpush "あああ", "this is my first tweet."
#puts redis.lrange "あああ", 0, 100
#10.times {|i| redis.rpush("tw", "times")}
#redis.lrange "あああ", 0, 20

# 計測しつつ1000回繰り返す
st =  Time.now
1000.times {|i| redis.rpush("ttt", "million#{i}")}
et = Time.now
puts et - st

# 構造化データ
require "json"
tmpjson = {:id => 1, :user => "shin", :time => Time.now, :body => "hello redis!"}
puts redis.set "tj", tmpjson.to_json
puts JSON.parse(redis.get("tj"))
=end

=begin
# seleniumテスト
require "selenium-webdriver"

driver = Selenium::WebDriver.for :chrome
driver.navigate.to "http://google.com"

element = driver.find_element(:name, 'q')
element.send_keys "Hello WebDriver!"
element.submit

puts driver.title

driver.quit
=end


=begin
# グローバル変数は$(ドル記号)で始める
$glo = "global!"
puts $glo
class Gtest
  puts $glo
  $glo = "change!"
  puts $glo
end
Gtest

# インスタンス変数は@(アットマーク)で始める
@ins = "instance!"
puts @ins
class Itest
  puts @ins # ない
  @ins = "change!"
  puts @ins
end
Itest

# クラス変数は@@(二重アットマーク)ではじめる
# @@cla = "class!" # warningでる
# puts @@cla
class Ctest
  def initialize
    @@cla = "change!"
    puts @@cla
  end
  
  #puts @@cla # 初期化してないのでエラーに
  @@cla = "class!"
  puts @@cla
end
Ctest.new
=end


=begin
# Range
p (1..3).to_a # x以下
p (1...3).to_a # x未満
=end

=begin
# getter setterの確認
class Attrclass
  def initialize
    @accessor = ""
    @reader = "readonly"
    @writer = ""
  end
  
  attr_accessor :accessor
  attr_reader :reader
  attr_writer :writer
  
  def reading
    @writer
  end
end

att = Attrclass.new

# 読み書きできる
att.accessor = "aaa"
puts att.accessor

# 書けない
#att.reader = "bbb"
puts att.reader

# 読めない
att.writer = "ccc"
#puts att.writer
puts att.reading # 読むメソッド
=end


=begin
# gem install git
require "git"
Git.open(".").pull()
=end

=begin
# gem install grit
Grit::Repo.new(".").commits[0].message
# pullはできないっぽい
=end


=begin
# ラムダ式を渡す形式
def testfunc( data, callback )
  callback.call( data )
end

data = { "a"=>1, "b"=> 2 }
lam = -> hash{ p hash }
testfunc( data, lam )
=end


=begin
# yieldでもできる
def testfunc( data )
    yield( data )
end

# Procを渡さないでblockを渡す的な
data = { "a"=>1, "b"=> 2 }
testfunc( data ){|hash|  p hash }
=end

=begin
# コールバックする関数($blockを追加)
def testfunc( data, &callback )
    callback.call( data )
end

# Procを渡さないでblockを渡す的な
data = { "a"=>1, "b"=> 2 }
testfunc( data ){|hash|  p hash }
=end


=begin
# コールバックする関数
def testfunc( data, callback )
  callback.call( data )
end

# コールバック用にProcを渡す
data = { "a"=>1, "b"=> 2 }
testfunc( data, Proc.new{|hash| p hash } )
testfunc( data, -> hash{ p hash } )
testfunc( data, proc {|hash| p hash } )

=end


=begin
# Couchbase接続サンプル確認
require 'rubygems'
require 'couchbase'

#client = Couchbase.connect(:bucket => "beer-sample", :host => "localhost")
client = Couchbase.connect("http://192.168.64.128:8091", :bucket => "beer-sample", :username => 'suzuki', :password => 'suzuki')

beer = client.get("aass_brewery-juleol")
puts "#{beer['name']}, ABV: #{beer['abv']}"

beer['comment'] = "Random beer from Norway"
client.replace("aass_brewery-juleol", beer)

client.disconnect

=end


=begin
# eval はObjectクラスのインスタンスメソッド
eval "puts self"
self.instance_eval "puts self"
=end

=begin
# procいろいろその弐
def myproc
  proc.call
  Proc.new.call
  lambda.call # warning
end

myproc do
  puts "pro"
end
=end


=begin
# procいろいろ
proc do
  puts 'proce'
end.call

lambda do
  puts 'lam'
end.call

-> {
  puts 'yajirusi'
}.call

-> x {
  puts x
}.call "yajirusi"
=end


=begin
def kurikaesi
    yield "asdf"
    yield "fefdf"
end

kurikaesi do |aaa|
  puts aaa
end
=end


=begin
# yieldを使ったフィボナッチ
def fib(n)
  i1,i2 = 0,1
  n.times do
    yield i1
    i1, i2 = i2, i1+i2
  end
end
fib(10){|n|puts n}
=end

=begin
def foo(val)
  yield val
end
foo(3) {|x| p  2 + x }
=end


=begin
def foo
  yield
end
foo { p  2 }
=end

=begin
# yieldは渡されたブロックと同じ働きをするメソッドのようなもの
def hogehoge( x )
  yield
  return x + 2
end
p hogehoge( 5 ){ p "foo" } # このブロックはyieldで実行される
=end

=begin
# ブロックを渡したとき
def hogehoge( x, &proc )    # &proc
  proc.call if block_given? # proc.call
  return x + 2
end

p hogehoge( 3 )
p hogehoge( 5 ){ p "foo" }

# yieldを使ったとき
def hogehoge2( x )      # &proc はない！
  yield if block_given? # proc.call が yield に！
  return x + 2
end

p hogehoge2( 3 )
p hogehoge2( 5 ){ p "foo" }
=end

=begin
proc2 = Proc.new{|a, b| ( a + b ) }
proc3 = Proc.new{|a, b| ( a + b ); ( a - b ) }

def proc2( a, b )
  return ( a + b )
end

# 手続き型オブジェクトを実行したときの値 ( メソッドで言うと戻り値 ) は、
# ブロック内で最後に評価された値になる。
p proc2.call( 3, 5 ) # 8
p proc3.call( 3, 5 ) # -2 (+はもどってこない)
p proc2( 4, 9 ) # 13
=end


=begin
# procとメソッドの違い
procedure = Proc.new{ p "hoge" }

p procedure.class
procedure.call

def definition
  p "moga"
end

# 実行される
p definition.class # 戻り値を返す(String)
definition
=end


=begin
# ブロックが与えられたときにcall
def hogehoge( x, &proc )
  proc.call if block_given?
  return x + 2
end

p hogehoge( 3 )
p hogehoge( 5 ) { p "foo" }
=end


=begin
# block_given?でブロックが存在するか確認できる
def hogehoge( x )
  p block_given?
  return x + 2
end

p hogehoge( 3 )
p hogehoge( 5 ){ p "foo" }
=end

=begin
# 全てのメソッドはブロックを引数にすることができる
def hogehoge( x )
  return x + 2
end
p hogehoge( 3 )
p hogehoge( 5 ){ p "foo" } # このブロックは無視される
=end

=begin
# yieldの確認その壱
def func
  yield("aaa")
end

func {| data |
  p data
}
=end


=begin
# コールバックの確認その参
puts "testes1"
def testfunc( data, callback )
  puts "testes4"
  callback.call( data )
  puts "testes7"
end
puts "testes2"

func1 = -> hash {
  puts "testes5"
  p hash
  puts "testes6"
}

puts "testes3"
data = { "a"=>1, "b"=> 2 }
testfunc( data, func1 )
puts "testes8"
=end


=begin
# コールバックの確認その弐
puts "testes1"
def testfunc( data, &callback )
  puts "testes4"
  callback.call( data )
  puts "testes7"
end
puts "testes2"

data = { "a"=>1, "b"=> 2 }
puts "testes3"
testfunc( data ){|hash|
  puts "testes5"
  p hash
  puts "testes6"
}
puts "testes8"
=end


=begin
# コールバックの確認その壱
puts "testes1"
def testfunc( data, callback )
  puts "testes5"
  sleep 2
  callback.call( data )
  puts "testes8"
end
puts "testes2"

puts "testes3"
data = { "a"=>1, "b"=> 2 }
puts "testes4"
testfunc( data, Proc.new { |hash|
  puts "testes6"
  p hash
  puts "testes7"
} )
puts "testes9"
=end


=begin
# mapの確認
[[1,"a"],[2,"b"],[3,"c"]].map do |e|
  p e.first
end
=end

=begin
# 時刻 フォーマット YYYYmmddHHMMSS
p Time.new.strftime("%Y%m%d%H%M%S")
=end

=begin
# CSVライブラリ
require "csv"
p [1,2,3].class
p [1,2,3].first
p CSV.class
=end

=begin
# 行と列の入れかえ
p [["aa",2],["bb",4],["cc",6]]
p [["aa",2],["bb",4],["cc",6]].transpose
# [["aa", "bb", "cc"], [2, 4, 6]]になる
# 要素数が一致しない場合はIndexErrorが返る
=end


=begin
# クロージャの確認
def closure
  x = 0
  puts x
  #return lambda {|n| x = x + n }
  return -> n{ x = x + n }
end

func = closure
x = -100
p func.call 1
p func.call 1
p func.call 1

p x
=end



=begin
# lambdaの練習
lam = lambda {|x| x * x }
puts lam.call 3

lam2 = -> x{ x * x }
puts lam2[3]

# Procはクラス(引数を指定しないとnilが入る)
pro = Proc.new do |x|
  x * x
end
puts pro.call 3

p lam.lambda?
p lam2.lambda?
p pro.lambda?
=end



=begin
# map関数(collectの別名)
a = [10, 20, 30, 40, 50]
p a.collect {|x| x*10} #=> [100, 200, 300, 400, 500]
p a #=> [10, 20, 30, 40, 50]
=end


=begin
# reduce関数(injectの別名)
# 1個目、2個目と渡され、前回の戻り値、3個目と渡される
number = [4,2,1,4] # 11
puts number.reduce {|memo,item| memo + item}
=end

=begin
# privateメソッドはサブクラスからも呼べる
# 親クラス
class Hoge
  def pro
    a_protected_method
  end
  def pri
    a_private_method
  end
  
  protected
  def a_protected_method
    "PROTECTED! - #{do_not_override_me}"
  end
 
  private
  def a_private_method
    "PRIVATE! - #{do_not_override_me}"
  end
 
  #May be overridden by sub class
  def do_not_override_me
    "I am Hoge."
  end
end

# 子クラス
class Piyo < Hoge
  def call_a_protected_method
    a_protected_method
  end
 
  def call_a_private_method
    a_private_method #OK!!
  end
 
  def call_a_protected_method_via(hoge_or_piyo)
    hoge_or_piyo.a_protected_method
  end
 
  def call_a_private_method_via(hoge_or_piyo)
    hoge_or_piyo.a_private_method #NG!!
  end
  
  private
  # Override a private method in super class and called from super class
  def do_not_override_me
    "I am Piyo."
  end
end

hoge = Hoge.new
piyo = Piyo.new

# 子クラスのprivateメソッドでオーバーライドされてる
puts piyo.call_a_protected_method
puts piyo.call_a_private_method

# 親クラスのメソッドを呼べる
puts piyo.call_a_protected_method_via(hoge)

# 親クラスのメソッドを呼べないのでエラー
#puts piyo.call_a_private_method_via(hoge)#ERROR!!

# 別クラスでも同じ
piyo2 = Piyo.new
puts piyo.call_a_protected_method_via piyo2
#puts piyo.call_a_private_method_via piyo2 #ERROR!!

# 自分を入れても同じ
puts piyo.call_a_protected_method_via piyo
#puts piyo.call_a_private_method_via piyo

# どちらもprivateで呼べない
#puts hoge.do_not_override_me
#puts piyo.do_not_override_me

# どっちも外からなので呼べない
#puts hoge.a_protected_method
#puts hoge.a_private_method

# 内側からのアクセス
puts hoge.pro
puts hoge.pri
=end


=begin
# カッコ不要
def testVar str, sss
  puts str + sss
end

testVar "aaaa", "bbb"
=end


=begin
# 単純なものはreturnを指定しなくてもOKぽ
def stringonly
  "why!"
end

puts stringonly
=end

=begin
# Rubyのクラスメソッドは同じクラスのprotectedメソッドや
# privateメソッドにアクセスできない
class Hoge
 def self.class_method
   hoge = Hoge.new
   puts_safe {hoge.public_method}
   puts_safe {hoge.protected_method}
   puts_safe {hoge.private_method}
 end

 def public_method
   "public"
 end


 protected
 def protected_method
   "protected"
 end

 private
 def private_method
   "private"
 end
end

def puts_safe
 puts yield
rescue => e
 puts "ERROR!! - #{e}"
end
puts Hoge.new.public_method
puts Hoge.new.protected_method
puts Hoge.new.private_method
=end


=begin
# strategyパターンの考察
class AbsNanigasi
  def say
    raise "this is abstract"
  end

  def bay
    puts "nothing"
  end
end

class Iti < AbsNanigasi
  def say
    puts "ichi"
  end
end

class Ni < AbsNanigasi
  def say
    puts "nii"
  end
end

Iti.new.say
Ni.new.say
Ni.new.bay
# ダックタイピングによって旨味がないかも。
=end


=begin
# ダックタイピングの試し書きその弐
def duckt(nanigasi)
  nanigasi.duck
end

class Nanika
  def duck
    puts "asdfasdf"
  end
end

class Nanikanoni
  def duck
    puts "nininini"
  end
end

duckt(Nanika.new)
duckt(Nanikanoni.new)
=end


=begin
# ディレクトリ内のクラスを呼ぶとパスが呼び出しもとを基準にされる。
# なのでFile.expand_pathを使って自分自身を起点に呼び出させる。
#require File.expand_path('../retstr.rb', __FILE__)
#puts File.expand_path('nanigasi.rb', "../ddd")

require './factory/bo.rb'
aaa = Bo.new
aaa.getter
=end

=begin
# オーバーライドかとおもったら違ったひっかけ問題。
class Test
  def test
    p 'aaa'
  end
end

obj =  Test.new

class Test
  def test
    p 'noanoanoa'
  end
end

obj.test
=end

=begin
# 論理演算子とビット演算子の確認
def returnTrueAndPutsTest
  puts "test"
  return true
end

# 論理演算子 orのとき後者を評価しない
if returnTrueAndPutsTest() || returnTrueAndPutsTest() 
  puts "logical operators"
end

# ビット演算子
if returnTrueAndPutsTest() | returnTrueAndPutsTest()
  puts "Bitwise operators"
end

=end

=begin
# 排他的論理和 ^^はない
if (true ^ false)
  p "tt"
else
  p "fal"
end
=end


=begin
# Mime::Type.lookup('text/plain')は、Mime::TEXTと省略して書くこともできます。
require 'action_dispatch/http/mime_type'
p Mime::TEXT
p Mime::HTML
=end

=begin
# binding 組み込み関数。実行すると、このメソッドを呼んだスコープの変数と
# 値の一覧を収めたオブジェクト(=bindingと呼ばれるもの）が返ってくる。

class Demo
  def initialize(n)
    @secret = n
  end
  def get_binding
    return binding()
  end
end

k1 = Demo.new(99)
b1 = k1.get_binding
k2 = Demo.new(-3)
b2 = k2.get_binding

p eval("@secret", b1)   #=> 99
p eval("@secret", b2)   #=> -3
p eval("@secret")       #=> nil
=end


=begin
# class#allocateはnewメソッドと異なりinisializeメソッドが呼ばれない
#aaa = Class.new do
class Hoge
  def initialize  
    puts 'initialize!!!'  
  end  

  def hoge
    p "hogehoge"
  end
end
aaa = Hoge.allocate
aaa.hoge

bbb = Hoge.new
bbb.hoge
=end


=begin
p c = Class.allocate
p d = Class.allocate
p c.send :initialize, d
p d.send :initialize, c

p c.class.allocate
p d.class.allocate
=end

=begin
=end

=begin
# class#allocate 自身のインスタンスを生成して返します
class Hoge
  def hoge
    p "hogehoge"
  end
end

aaa = Hoge.allocate
p aaa.class
aaa.hoge

bbb = Hoge.new
p bbb.class
bbb.hoge
=end



=begin
# privateだとオブジェクトの外からでも呼べない
class HogeSuper
  protected
  def protected_method
    puts "protected"
  end
  
  private
  def private_method
    puts "private"
  end
end

class Hoge < HogeSuper
  def hoge
    protected_method # OK
    private_method # OK
    a = Hoge.new
    a.protected_method # OK
    #a.private_method # Error
  end
end
Hoge.new.hoge
=end


=begin
# protected を使うと、サブクラスのインスタンスが「オブジェクトの外から」
# メソッドを呼べるようになります。
class Protest
  def toprotect
    puts "OK"
  end
  protected :toprotect

  def call_m(a)
    a.toprotect
  end
end

mm = Protest.new
mm.call_m(Protest.new)
mm.toprotect

#Protest.new.call_m(Protest.new)   # これは大丈夫
#Protest.new.toprotect               # これはダメ
=end


=begin
# Kernel#binding を使用すれば現在のスコープを(Binding)オブジェクトの形で取得することが出来る
class C
  def m
    @x = 20
    y = 30
    binding
  end
end

b = C.new.m
p b.class
p eval "@x", b
p eval "y", b

# トップレベルのスコープを取得したい場合は Ruby の組込み定数 TOPLEVEL_BINDING を使用する。
class C2
  def get_self
    eval "self", TOPLEVEL_BINDING
  end

  def get_b
    eval "b", TOPLEVEL_BINDING
  end
end

obj = C2.new
p obj.get_self
p obj.get_b
=end



=begin
# eachはスコープを生成するので、
# code=$1はeachブロック内のローカル変数と見なされます。
#DATA.each do |line|
while line = DATA.gets
  if /code,(.+)/=~line
    code=$1
  elsif /name,(.+)/=~line
    puts "code= #{code}"
    puts "name= #{$1}"
  end
end


__END__
code,001
name,ipp
code,002
name,opp
=end


=begin
# __END__ 以降のデータをDATA定数でアクセスできる。
DATA.each{|line|
  one = line.chomp.split(/ /)
  puts "#{one[0]} is #{one[1]} years old"
}
p DATA.gets

__END__
toshi 32
youko 26
mamoru 12
kako 8
hisanori 5

=end

=begin
# エイリアス
$aaa = "asdfj" 
p $aaa
# グローバル変数でないとうまくいかなかった。
alias $bbb $aaa
$aaa = "ikkaime"
p $aaa
p $bbb
$bbb = "nnikkaime"
p $aaa
p $bbb
=end


=begin
# pではinspectが呼ばれる
class Test
   def initialize
     @a = Array.new
     @b = Array.new
   end
   
   def to_s
     "call to_s"
   end
   
   def inspect
     "call inspect"
   end 
end

# 「if __FILE__ == $0」現在実行中のスクリプトが、
# ファイル名と同じものの場合、この条件は真になる
# requireなどで使う場合には条件が偽となり表示処理はおこなわれず、
# このスクリプト単体で実行する場合にだけ、
# 表示処理を実行させることができるようになる。
if __FILE__ == $0
   test = Test.new
   p test
   print test
   puts test
end
=end


=begin
# sqliteの練習
require 'sqlite3'

File.delete("data.db")
db = SQLite3::Database.new("data.db")

# テーブル作成
sql = <<SQL
create table 社員 (
  名前 varchar(10),
  年齢 integer,
  部署 varchar(200)
);
SQL
db.execute(sql)


# レコード登録
sql = "insert into 社員 values ('橋本', 26, '広報部')"
db.execute(sql)


# プレースホルダとバインド値を使用した場合
sql = "insert into 社員 values (?, ?, ?)"
db.execute(sql, '小泉', 35, '営業部')
db.execute(sql, '亀井', 40, '営業部')


# 名前付きプレースホルダも使用可能
sql = "insert into 社員 values (:name, :age, :post)"
db.execute(sql, :name => '小泉nam', :age => 35, :post => '営業部')
db.execute(sql, :name => '亀井nam', :age => 40, :post => '営業部')


# レコード取得
db.execute('select * from 社員') do |row|
  #rowは結果の配列
  puts row.join("\t")
end



# レコード更新
#小泉の部署を広報部に更新する
db.execute("update 社員 set 部署='広報部' where 名前='小泉'")


# レコード削除
# 亀井を削除
db.execute("delete from 社員 where 名前='亀井'")

db.close
=end


=begin
# system実行
system "echo 'dummy'"
=end


=begin
# ramaze動作チェック
require 'ramaze'

class MainController < Ramaze::Controller
  def index
    'Hello, World!'
  end
end

Ramaze.start

=end


=begin
# 大文字にする
File.open("list_place.txt") do |line|
  File::open("lp.txt", "a").write(line.read.upcase)
end
=end


=begin
# 式展開
name = "東京"
print("出身は #{name} です")
=end

=begin
# 動的にインスタンスメソッドを定義
class DynamicMethod
  define_method("aaa") do
    puts "define"
  end
end

dm = DynamicMethod.new
p dm.methods.select{|i| i=~/aa/} # => ["my_method_1", "my_method_2"]
=end

=begin
# オブジェクトをダンプする
p Marshal.dump("aaa")
=end

=begin
# 繰り返し検索(配列)
text = "asdfkjhd"
p text.scan(%r{d})

text.scan("k") { p text }
# 二回発見されたら二回実行される
# text.scan(/\r?\n/) { @current_line += 1 }
=end


=begin
# 末尾の一文字を取り除く
match = "aaa"
p match.chop!
p match.chop!
p match.chop!
=end


=begin
# 破壊的chomp
p aaaa = "abcddbvadad"
p dd = aaaa.chomp('d')
p aaaa
p dd

p value = "abcddbvadad"
p vv = value.chomp!('d') # 処理されなければnil
p value 
p vv
=end


=begin
#endにdelete
ccc = if true
  "avaab"
end.delete("a")

p ccc
=end

=begin
# 正規表現リテラル
p %r{^(\w[\w+.-]*:|//).*}

p %r{[d]bc}
p "abcdbce".index(%r{[d]bc})
=end


=begin
# delegete
require 'delegate'
foo = Object.new

def foo.test
  p 25
end

foo2 = SimpleDelegator.new(foo)
foo2.test # => 25

foo3 = foo
foo3.test

p foo.__id__
p foo2.__id__ # 別のオブジェクト
p foo3.__id__


class ExtArray<DelegateClass(Array)
  def initialize()
    super([])
  end
end

a = ExtArray.new
p a.class  # => ExtArray

a.push 25
p a       # => [25]
=end


=begin
require 'fileutils'
FileUtils::makedirs("aaa")
=end

=begin
# sendはprotectedなメソッドもprivateなメソッドも呼び出せます。
class Cat
  private
  def hello(n = nil)
    n ? Array.new(n, "meow!") : "meow!"
  end
end
 
cat = Cat.new
p cat.__send__(:hello, 3)
p cat.hello # privateにするとエラー
=end


=begin
# 式が定義されていなければ、偽を返します。定義されていれば式の種別 を表す文字列を返します。
class Aaa
  def jiji
  end
end
ccc = Aaa.new
p defined? ccc
=end


=begin
# オブジェクトのidを取得
a = "hoge"
p ObjectSpace._id2ref(a.__id__) #=> "hoge"

aa = 0
p aa.__id__
p 0.__id__

p ObjectSpace.count_objects
=end


=begin
# 全てのオブジェクトを操作するためのモジュールです。
p ObjectSpace.class
=end

=begin
#自分の開発しているクラスファイルの最後に記述しておくと、
#そのクラスファイルを ruby で実行するだけで、irb が立ち上がってプログラムのテストができる。
#irb(main):001:0> hello
#hello, world
require 'irb'
def hello()
  puts "hello, world"
end
#IRB.start

if __FILE__ == $0
  require 'irb'
  IRB.start
end
=end


=begin
#クラスに所属するメソッド.オブジェクトを生成しなくても呼び出せる.
#記法はオブジェクト名.メソッド名(例 String.dup)
p String.methods
=end


=begin
#モジュールメソッド
#モジュールに属するメソッド.クラスオブジェクト同様オブジェクトがなくても呼び出せる.
p GC.methods
=end


=begin
# 現在行
p __LINE__
=end


=begin
# class_eval
Fixnum.class_eval "def number ; self ;end"
p 5.number #=> 5
=end

=begin
# instance_eval
class Klass
  def initialize
    @secret = 99
   end
end
k = Klass.new
p k.instance_eval { @secret }   #=> 99 , notice the @
p Klass.class_eval { @secret }

# シングルトンメソッドを定義するのに使うこともできます。
p Fixnum.instance_eval "def zero; 0 ;end"
p Fixnum.zero #=> 0

# 文字列の代わりにblockを渡すことができます。
p Fixnum.instance_eval{ def ten ;10;end }
p Fixnum.ten #=> 10
=end


=begin
# eval族
p eval "3+4" #=> 7
p eval "def multiply(x,y) ; x*y; end"
p multiply(4,7) #=> 28

class Demo
  def initialize(n)
    @secret = n
  end
  def getBinding
    return binding()# a method defined in Kernel module
  end
end
k1 = Demo.new(99)
#get the value of the instance variable @secrete stored in the binding of object k1
p eval("@secret", k1.getBinding)   #=> 99

def greeting(name)
  lambda{|greetings| greetings.collect {|g| "#{g} #{name}"} }
end
greeter = greeting("dude")
p greeter #=> #<Proc>
p greeter.call ["hi","hello","hola"] #=> ["hi dude", "hello dude", "hola dude"]
# 出来なかった
eval("name='khelll'",greeter) #=> "khelll"
p greeter.call ["hi","hello","hola"] #=> ["hi khelll", "hello khelll", "hola khelll"]
=end


=begin
# 配列の中に配列を入れる
a = []; a << a
p a
=end


=begin
# class class
MyHash = Class.new(Hash)
p MyHash # MyHashクラス
p MyHash.class # クラス
p MyHash.new # MyHashの中身
p MyHash.new.class # MyHashクラス

st = Class.new(String)
p st
p st.class
p st.new
p st.new.class
=end


=begin
# Procとlambdaの違い
cc = lambda {p "tata"}
cc.call
cc.yield

b1 = Proc.new{|a,b,c| p a,b,c}
b1.call(2, 4)

b2 = lambda{|a,b,c| p a,b,c}
b2.call(2, 4) # エラーになる
=end


#=> wrong number of arguments (2 for 3) (ArgumentError)
=begin
# Proc.new call yield(callをProc.newせずに使える)
aa = Proc.new{ Time.now.to_i.to_s }
p aa.call
p aa.yield

Proc.new{p "tete"}.call
Proc.new{p "toto"}.yield

def foo
  pr = Proc.new
  pr.call(99)
end
foo {|arg| p arg }

def baa
  yield(99)
end
baa {|arg| p arg }

def buz
  Proc.new.call(88)
  proc.call(99)
  yield(77)
end
buz {|arg| p arg }
=end


=begin
# inspectメソッドは制御文字や非アスキー文字を
# バックスラッシュ記法に置き換えた文字列を返す
p "Look its HAML!"
p "Look its HAML!".inspect
=end

=begin
# %Q ダブルクオーテーション
# %q シングルクオーテーション
puts %Q{<img alt='Somelogo' src="tp://images.example.com/images/somelogo.png" />}
p %Q{<img alt='Somelogo' src="tp://images.example.com/images/somelogo.png" />}

puts %q{<img alt='Somelogo' src="tp://images.example.com/images/somelogo.png" />}
p %q{<img alt='Somelogo' src="tp://images.example.com/images/somelogo.png" />}

p %Q{文字列}
p %Q[文字列]
p %Q(文字列)
p %Q<文字列>

p %Q|文字列|
p %Q!文字列!
p %Q*文字列*

# 配列リテラル
p %w{"I" 'am' opamp}
p %W{"I" 'am' opamp}
=end


=begin
# メソッド呼び出し可能かチェック
class Cat
  def hello
    "meow!"
  end
  
  private
  def sleep
    "zzz..."
  end
end
cat = Cat.new
p cat.respond_to?(:hello)
p cat.respond_to?("sleep")
=end

=begin
# super
class Foo
  def foo(arg=nil)
    p arg
  end
end

class Bar < Foo
  def foo(arg=nil)
    super(5)       # 5 を引数にして呼び出す
    super(arg)     # 5 を引数にして呼び出す
    super          # 6 を引数にして呼び出す super(arg) の略記法
    arg = 1
    super          # 1 を引数にして呼び出す super(arg) の略記法
    super()        # 引数なしで呼び出す
  end
end
Bar.new.foo
=end

=begin
# スレッドローカルスコープ
# スレッドで最後に終了した子プロセスのステータス
p $?

# 最近の例外に関する情報。raiseによって設定される
p $!

# バックトレースを表す配列
p $@

# カレントスレッドのセーフレベル
p $SAFE
=end

=begin
# 組込定数
p TRUE
p FALSE
p NIL
p STDIN
p STDOUT
p STDERR
p *ENV
p ARGF
p ARGF.gets
p gets
p *$*
p ARGF.file
p ARGF.filename
p ARGV
p __FILE__
p $0 # 実行されたファイル
p $1 # nil
#p __END__
p RUBY_VERSION 

# major.minor.teeny 二桁以上にならないらしい
if RUBY_VERSION >= '1.9.9'
  # バージョン 1.9.9 以降で有効な処理
  puts "有効！"
else
  # それ以前のバージョンで有効な処理
  puts "無効！"
end
p RUBY_RELEASE_DATE
p RUBY_PLATFORM
p RUBY_PATCHLEVEL
=end

=begin
# 別名定義。危険らしい
class Foo
  class << self
    def bar
      return 'bar'
    end
    alias foo bar
  end
end

p Foo.bar #=> 'bar'
p Foo.foo #=> 'bar'
=end


=begin
# ブロックを引数で渡して実行可能
def foo(cnt, &block_arg)
  cnt.times { block_arg.call } # ブロックに収まったProcオブジェクトはcallで実行
end
foo(3) { print "Ruby! " } #=> Ruby! Ruby! Ruby! 
=end


=begin
# アスタリスクで配列を分解
p *ARGV
=end


=begin
# 自己代入演算子
a = "jijij"
a ||= "aaaa"
p a
=end


=begin
p $LOAD_PATH
p $:
#.unshift("mkdir")

# ファイルからの相対パスでLOAD_PATHにパスを追加する定石コード。
$:.unshift(File.dirname(__FILE__))
$:.unshift(File.dirname(__FILE__) + "/lib")
#$:は$LOAD_PATHの別名。上記のように書くことでスクリプトファイルからの
#相対パスでLOAD_PATHに新しいパスを追加できる。
#注意しなくてはならいのは、evalなどを使う場合で、その場合は__FILE__が
#スクリプトファイルのパスにならないので使用できない。
=end


=begin
# 相対パスを絶対パスへ
p File.expand_path("./mkdir", "c:\\ht")
=end


=begin
p nil || ""
p nil or ""
p nil | ""
=end

=begin
# ディレクトリ
p Dir::pwd
Dir::rmdir("mkdir")
Dir::mkdir("mkdir")
p Dir::entries("mkdir")
=end


=begin
# ハッシュを使うときはシンボルを使う
h = {:apple=>150, :banana=>300, :lemon=>300}
p h[:apple] #=> 150
p h.fetch(:apple) #=> 150
=end

=begin
# ハッシュ
#h = {"apple"=>150, "banana"=>300, "lemon"=>300}
#h = Hash::new
h = {"apple"=>150}
h.store('banana', 200)
h['lemon'] = 300

h.default = 100 # デフォルトを設定してもfetchでは例外

p h.key?('apple') #=> true
p h.has_key?('orange') #=> false
p h.include?('lemon') #=> true
p h.member?('avocado') #=> false


p h['apple'] #=> 150
p h['banana'] #=> 200
p h['lemon'] #=> 300
p h['papaia'] #=> nil

p h.delete('banana')

p h.fetch('apple') #=> 150
p h.fetch('papaia', 500) #=> 500
p h.fetch('papaia') { 500 } #=> 500
#p h.fetch('papaia') #=> IndexError

fruits = []
h.each_key {|key| fruits.concat([key])}
p fruits #=> ["apple", "banana", "lemon"]

sum = 0
h.each_value {|value| sum += value}
p sum #=> 750

h.each_pair {|key, value| puts "#{key}: \\#{value}"}
#=> "banana: \300"
#=> "apple: \150"
#=> "lemon: \300"
=end


=begin
# ラッパーを使ったrack
require 'rack/request'
require 'rack/response'

class RackApp
  def call(env)
    req = Rack::Request.new(env)

    body = case req.request_method
           when 'GET'
             '<html><body><form method="POST"><input type="submit" value="loook？" /></form></body></html>'
           when 'POST'
             '<html><body>baboon</body></html>'
           end

    res = Rack::Response.new { |r|
      r.status = 200
      r['Content-Type'] = 'text/html;charset=utf-8'
      r.write body
    }
    res.finish
  end
end
=end


=begin
# ラッパーを使わないrack
class RackApp
  def call(env)
    p env
    case env['REQUEST_METHOD']
      when 'GET'
        [
          200,
          { 'Content-Type' => 'text/html' },
          ['<html><body><form method="POST"><input type="submit" value="look?" /></form></body></html>']
        ]
      when 'POST'
        [
          200,
          { 'Content-Type' => 'text/html' },
          ['<html><body>何よ</body></html>']
        ]
      end
  end
end
=end


=begin
# スレッドへ引数を渡す
puts "Test start"
puts "Create thread"
def make(foo)
    puts "Start thread" + foo
    sleep 3
    puts "End thread"
end
puts "Waiting for the thread to complete"
tq = Thread.new{make("aaad")}
tq.join
puts "Test compleated"
=end

=begin
# 自前ミリ秒ストップウォッチ
starttime = Time.now
sleep 0.1
endtime = Time.now
File::open("linklog.txt", "a").write((endtime - starttime).to_f.to_s + "\n")
=end

=begin
# ログ用ファイル追記
File::open("linklog.txt", "a").write("aaaa\n")
=end


=begin
# 文字数を取得した。
strData = 'あいうえお'
print strData.size
print strData.length

=end


=begin
# プリントフォーマット
printf "ああああ%s", "aaa"
=end

=begin
# 配列では使えない
a = [1,2,3]
p a

1.times {|line|
  p line
}
=end


=begin
puts '名前を入力してください。'
name = gets.chomp
puts "あなたの名前は#{ name }です。"
=end


=begin
# mapとcollectは内部的には違うらしい
(1..10).map { |x|
  puts x
}

(1..10).collect { |x|
  puts x
}
=end

=begin
# ラムダ式の試し書き
lambdaexp = -> base{ base == "aa" }
puts lambdaexp["bb"]
=end


=begin
# ダックタイピングの試し書き
class Claa
  def methooood
    puts "errerere"
  end
end
class Claa2
  def methooood
    puts "asdfasdf"
  end
end
class Act
  def exxx(a)
    a.methooood
  end
end

a = Act.new
b = Claa.new
c = Claa2.new
a.exxx(b)
a.exxx(c)
=end



=begin
#{}からdo endへ
File.open("list1.txt") do |f| # ファイルを開いて、対応する
                                 # Fileオブジェクトを変数fに設定
  line = 0
  f.each_line do                 # ファイル中の各行に対して繰り返し
    line += 1                    # カウンタ値をインクリメント
  end
  puts "行数は#{line}です"
end

=end


=begin
#getter setter 2
class Attttclass
  def initialize
    @field1 = ""
    @field2 = ""
    @field3 = ""
  end
  
  attr_accessor :field1, :field2, :field3
  attr_reader :field1, :field2, :field3
  attr_writer :field1, :field2, :field3
end

o = Attttclass.new
puts o.field1
o.field1 = "aaa"
puts o.field1

=end

=begin
# getter setter
def field1
  return @field1
end
def field1=(new_field1)
  @field1 = new_field1
end

puts field1
field1 = "settin"
puts field1
=end



=begin
#リンクチェック移植
require "net/http"
require "uri"

#＊同じ名前のテキストを読み込む
file = $0.gsub("rb", "txt").split("/").pop

#＊結果ファイル名
resultfile = "result_" + file

File.readlines(file).each do |line|
  if /^http/ =~ line
    begin
      #URLの取得
      response = Net::HTTP.get_response(URI.parse(line))
      case response
        when Net::HTTPSuccess
          next
        else
          open(resultfile, "a+").write(line.chomp)
          open(resultfile, "a+").write(" " + response.code + "\n")
      end
    rescue
      open(resultfile, "a+").write(line)
    end
  end
end
=end


=begin
# ステータスコードのみを取得する
require "net/http"
response = Net::HTTP.get_response(URI.parse('http://www.yahoo.co.jp/'))
puts response.code
if response.code == "200"
  puts "ok"
else
  puts "ng"
end
=end


=begin
#MD5変換
require "digest/md5"
md5 = Digest::MD5.new.update("hashhash");
puts md5
=end


=begin
# shiftは配列の先頭を返却し、削除する
puts $*[0]
puts $*.shift
puts $*[0]
=end


=begin
# コマンド名を取得
puts $0

# 引数を配列で取得
puts $*
puts $*[1]
=end


=begin
# 出力時の変換。先に定義されていないといけない
lis2 = "AMAYA"
tex = "itibann#{lis2}itibandesu"
puts tex
=end

=begin
# %文字列配列と出力時の返還
%w(one thow shoien).each do |arrr|
  sttt = "asd#{arrr}gghhg"
  puts sttt
end
=end

=begin
# OSコマンド
`dir>aaa`
=end

=begin
# 引数
puts ARGV[0]
=end


=begin
#つかったらケス
# 対象バイナリファイルをbinreadで読込み、pack('m')でBase64にし出力先に書き込む
File.write("result_k84.txt", [File.binread("k89.7z")].pack('m'))

# 対象ファイルを読込み、unpack('m')でバイナリにし出力先へbinwriteでバイナリで書き込む
#File.binwrite("k89.7z", File.read("result_k84.txt").unpack('m')[0])
=end

=begin
class Tmp
  def initialize(x, y)
    @x = x
    @y = y
  end
  
  def getX()
    return @x
  end
  
  def getY()
    return @y
  end
  
  # 演算子オーバーライド というものらしい・・・
  def ==(point)
    return (@x == point.getX()) && (@y == point.getY())
  end
end

aaa = Tmp.new(1,2)
puts aaa.getX
puts aaa.getY
puts aaa == Tmp.new(1,2)
=end


=begin
class Tmp
  def str
    return "TmpOut"
  end
end

#ttt = Tmp.new
#puts ttt.str
=end


=begin
# テンプレ機能 ワンライナー的な感じだと見にくいので分解する
listweet = File.readlines("list1.txt")[rand(File.readlines("list1.txt").length)]
if (listweet.index("{0}") != nil)
  listweet = listweet.gsub("{0}",File.readlines("list2.txt")[rand(File.readlines("list2.txt").length)].chomp)
end
puts listweet

#puts File.readlines("list1.txt")[0]
#puts File.readlines("list1.txt").length
=end


=begin
# 時間によって発言を変える
require "./betweenhour"
tmorningbgn = 6
tmorningend = 9

bh = BetweenHour.new()
if bh.isBetweenHour(tmorningbgn,tmorningend,Time.now.hour) == true
  puts "OK"
end
=end

=begin
# 時間帯の範囲を指定し、falseならOK
require "./betweenhour"
tstopbgn = 23
tstopend = 7

bh = BetweenHour.new()
if bh.isBetweenHour(tstopbgn,tstopend,Time.now.hour) == false
  puts "OK"
end
=end


=begin
# binloadを利用してのIO
# 対象バイナリファイルをbinreadで読込み、pack('m')でBase64にし出力先に書き込む
File.write("result_b64.txt", [File.binread("a.msg")].pack('m'))

# 対象ファイルを読込み、unpack('m')でバイナリにし出力先へbinwriteでバイナリで書き込む
File.binwrite("b.msg", File.read("result_b64.txt").unpack('m')[0])
=end


=begin
#loopテスト。doがないとエラーになった。
#loopはメソッドでありスコープが閉じられている。
#while trueは制御文なので、抜けた後もスコープが有効。
loop do
  puts "a"
end
=end


=begin
#MF試験問題
class BetweenHour
  # ある時刻(0時～23時)が、指定した時間の範囲内に含まれるかどうかを調べる
  def isBetweenHour(beginHour, endHour, checkHour)
    # 受け取った値が数値か確認
    if (beginHour.class != Fixnum || endHour.class != Fixnum || checkHour.class != Fixnum)
      raise
    end
    
    # 24以上の値を指定した場合エラー
    if (beginHour >= 24 || endHour >= 24 || checkHour >= 24)
      raise
    end
    
    # 日付型へ変換
    beginHour = Time.gm(0,1,1,beginHour)
    endHour = Time.gm(0,1,1,endHour)
    checkHour = Time.gm(0,1,1,checkHour)
    
    # 開始時刻と終了時刻が同じ場合は含まれる
    if (beginHour == checkHour && checkHour == endHour)
      return true
    end
    
    # 開始時刻が終了時刻より大きい場合日跨ぎ判定
    if (beginHour > endHour)
      endHour = Time.gm(0,1,endHour.day + 1, endHour.hour)
      
      # 開始時刻が判定時刻より大きい場合日跨ぎ判定
      if (beginHour > checkHour)
        checkHour = Time.gm(0,1,checkHour.day + 1, checkHour.hour)
      end
    end

    # 範囲指定は開始時刻を含み終了時刻は含まない
    if (beginHour <= checkHour && checkHour < endHour)
      return true
    end
    
    return false

  end
end

#bh = BetweenHour.new()
#puts bh.isBetweenHour(1,2,3)

=end


=begin
class Tmp
    def initialize(x, y)
        @x = x
        @y = y
    end
    
    def getX()
        return @x
    end
    
    def getY()
        return @y
    end
    
    def san(s)
      @s = s
    end
    
    def getsan
      return @s
    end
    
    def ==(point)
        return (@x == point.getX()) && (@y == point.getY())
    end
end
=end




=begin
# 型比較
puts "aa".class
if "aa".class == String || 1.class == Fixnum
  puts "ok"
end
=end


=begin
f = File::open("test.txt", "w+")
f.write("012367")
#f = File::open("test.txt", "r")
# w+の場合この時点ではファイルに書き込みされていないので途中で書き込む必要有
print f.read
=end


=begin
# File.readのほうがいいらしい
open("b.msg", "wb").write(File.read("result_b64.txt", :encoding => Encoding::UTF_8).unpack('m')[0])
=end

=begin
# 対象ファイルを開き、unpack('m')[0]でバイナリにし出力先に書きこむ
open("b.msg", "wb").write(open("result_b64.txt", "r+").read.unpack('m')[0])
=end

=begin
# Base64ファイルを入力
open("oauth.txt").each {|line|
  line？
}
# base64->binに変換
# binなテキストファイルを出力
open("result.txt", "a+") {|file|
  file.write(#なかみ + "\n")
}
=end



=begin
# 対象ファイルを読込バイナリで開き、pack('m')でBase64にし出力先に書きこむ
open("result_b64.txt", "w").write([open("a.msg", "rb").read].pack('m'))
=end



=begin
# binファイルを入力
#binmsg = open("a.msg", "rb")
# bin->base64に変換
#while(bin = binmsg.read(4))
#  base64_text = binmsg.pack('i*')
#  
#end
# Base64なテキストファイルを出力
open("result_b64.txt", "w") {|file|
  file.write([open("a.msg", "rb").read].pack('m'))
}
=end
#ワンライナーにしたけど読みにくいね・・・



=begin
# maroichi
require 'rubygems'
require 'twitter'

lineArray = Array.new()
open("oauth.txt").each {|line|
  lineArray.push line
}

Twitter.configure do |c|
  c.consumer_key = lineArray[0].chomp
  c.consumer_secret = lineArray[1].chomp
  c.oauth_token = lineArray[2].chomp
  c.oauth_token_secret = lineArray[3].chomp
end

tweet = "時間確認2"
# 時間を格納
firsttime = Time.now()
# 発言！
Twitter.update(tweet)

# できるまで(例外が発生しなくなるまで)発言
while (true)
  sleep 60
  #puts "---"
  begin
    Twitter.update(tweet)
  rescue
    # 例外発生時
    #puts "例外"
    open("1log.txt", "a+") {|file|
      file.write(Time.now().to_s + "\n")
    }
  else
    # 例外無
    puts "例外なし"
    # できた！
    # 時間を格納
    # どのくらいたったか比較してログへ書き込み
    successtime = Time.Now()
  ensure
    # 必ず実行
    #puts "必ず実行"
  end
end

open("GreetingsFromMaro1.txt", "a+") {|file|
  file.write(firsttime.to_s + "\n")
  file.write(successtime.to_s + "\n")
}
=end

=begin
#無限ループ
while (true)
  puts "aaa"
  sleep 1
end
=end

=begin
#ファイル追記
open("write.txt", "a+") {|file|
  file.write(Time.now.to_s + "\n")
}
=end


=begin
temp = "てあ{0}すと"
pos = temp.index("{0}")
if (pos != nil)
  puts temp.gsub("{0}","AOYAMA")
end
=end


=begin
#文字列置換
tempple = ["A","B"]
temp = "て{0}すと"
puts temp.gsub("{0}",tempple[rand(2)].chomp).encode("Shift_JIS")
=end


=begin
i=2
p i
i+=3
p i
j=0
j+=i
p j
j+=i
p j
=end


=begin
# 下のと同じ
(1..10).each do |i|
  puts i
end
=end


=begin
for i in 1..10 do
  puts i
end
=end


=begin
#外部ファイルからキー読み込み
require 'rubygems'
require 'twitter'

lineArray = Array.new()
open("oauth.txt").each {|line|
  lineArray.push line
}

Twitter.configure do |c|
  c.consumer_key = lineArray[0].chomp
  c.consumer_secret = lineArray[1].chomp
  c.oauth_token = lineArray[2].chomp
  c.oauth_token_secret = lineArray[3].chomp
end
tweet = "ねええすと"
puts tweet.encode("Shift_JIS")
Twitter.update(tweet)

=end

=begin
#2012/07/06 15:47
lineArray = Array.new()
open("list1.txt").each {|line|
  lineArray.push line
}
#print lineArray.length
print lineArray[rand(lineArray.length - 1)]
=end


=begin
#2012/07/06 14:28
open("list1.txt").each {|line|
  print line
}
=end


=begin
#2012/07/06 14:23
# 指定ファイルの行数を返します.
filename = "list1.txt"
def getNumLine( filename )
  File.open( filename ) { |file|
    nil while file.gets # ファイル末尾まで移動.
    return file.lineno  # 現在の行番号を出力.
  }
  return -1 # error.
end

print getNumLine(filename).to_s
=end


=begin
#2012/07/06 14:06
filecount = 0
open("list1.txt") {|file|
  filecount = file.read.count("\n") + 1
  p filecount
}

i = 0
while i < 10
  open("list1.txt") {|file|
    print file.readlines[rand(filecount)]
  }
  i = i + 1
end
=end


=begin
#2012/07/06 14:06
filecount = 0
open("list1.txt") {|file|
  filecount = rand(( file.read.count("\n") + 1 ))
  p filecount
}

open("list1.txt") {|file|
  print file.readlines[filecount]
}
=end


=begin
  i = 0
  while i < 5
    print file.readlines[rand(file.read.count("\n")+1)]
    i = i + 1
  end
=end


=begin
#2012/07/06 13:45
#ファイル内の全行数をrandへ入れる
#ファイルは小さい予定なので\nの数を数えるという手段で行うことにする。(13が取得)
open("list1.txt") {|file|
  #p file.read.count("\n")
  filecount = rand(( file.read.count("\n") + 1 ))
  p filecount
  #print file.readlines[filecount]
  #p rand(file.read.count("\n")+1) #整数を足すとintになる
  #print file.readlines[14] # 存在しないと空白
}
=end

=begin
#別解 (14が取得される)
fp = open('list1.txt')
line_count = 0
while fp.gets
  line_count += 1
end
p line_count
=end


=begin
2012/07/06 13:45
i = 0
while i < 5
    puts rand*10
    i = i + 1
end
=end


=begin
#2012/07/06 13:43
open("list1.txt") {|file|
  print file.readlines[rand*10]
}
=end



=begin
#2012/07/06 13:36
aaa = rand(3)
p aaa
=end 


=begin
#2012/07/06 13:23
i = 0
while i < 3
    puts Time.now
    i = i + 1
    sleep 1
end
=end 

