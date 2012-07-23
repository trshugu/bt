#!ruby
# -*- coding: utf-8 -*-
=begin
=end

puts "aaa"


















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


