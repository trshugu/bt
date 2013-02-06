#!ruby
# coding: utf-8
=begin
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

