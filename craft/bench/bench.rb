#!ruby
# coding: utf-8
=begin
=end

require "net/http"
require "uri"
require "parallel"
require "logger"

# ----------------------------------------------------------
# ランダムにWebにアクセスする用
# ----------------------------------------------------------
def get_webs
  urls = []
  if Object.const_defined?(:DATA)
    DATA.each_line do |l|
      urls.push(l.chomp)
    end
  end
  
  webs = []
  urls.each do |url|
    webs.push("http://" + url + ":4567/")
  end
  
  if ARGV[0] == "redis"
    puts "redis"
    webs.map!{|web| web + "web-redis/"}
  else
    webs.map!{|web| web + "web/"}
  end
  
  return webs
end


# ----------------------------------------------------------
# サーバーパターン用構成
# ----------------------------------------------------------
def bench_pattern(args)
  urls = []
  if Object.const_defined?(:DATA)
    DATA.each_line do |l|
      urls.push(l.chomp)
    end
  end
  
  webs = []
  case args
    when "1"
      webs.push("http://" + urls[0] + ":4567/")
      webs.map!{|web| web + "web/"}
    when "2"
      webs.push("http://" + urls[0] + ":4567/")
      webs.push("http://" + urls[1] + ":4567/")
      webs.map!{|web| web + "web/"}
    when "3"
      webs.push("http://" + urls[0] + ":4567/")
      webs.push("http://" + urls[1] + ":4567/")
      webs.push("http://" + urls[2] + ":4567/")
      webs.map!{|web| web + "web/"}
   
    when "4"
      webs.push("http://" + urls[0] + ":4567/")
      webs.map!{|web| web + "web-redis/"}
    when "5"
      webs.push("http://" + urls[0] + ":4567/")
      webs.push("http://" + urls[1] + ":4567/")
      webs.map!{|web| web + "web-redis/"}
    when "6"
      webs.push("http://" + urls[0] + ":4567/")
      webs.push("http://" + urls[1] + ":4567/")
      webs.push("http://" + urls[2] + ":4567/")
      webs.map!{|web| web + "web-redis/"}
    
    when "7"
      webs.push("http://" + urls[0] + ":4567/web/")
      webs.push("http://" + urls[1] + ":4567/web-redis/")
    when "8"
      webs.push("http://" + urls[0] + ":4567/web/")
      webs.push("http://" + urls[1] + ":4567/web/")
      webs.push("http://" + urls[2] + ":4567/web-redis/")
    when "9"
      webs.push("http://" + urls[0] + ":4567/web/")
      webs.push("http://" + urls[1] + ":4567/web-redis/")
      webs.push("http://" + urls[2] + ":4567/web-redis/")
  end
  
  return webs
end

# ----------------------------------------------------------
# キャッシュクリア
# ----------------------------------------------------------
def CacheCrear(webs)
  webs.each do |uri|
    begin
      res = Net::HTTP.get_response(URI.parse(uri + "cache_refresh"))
      body = res.body if res.is_a?(Net::HTTPSuccess)
    rescue => ex
      puts ex
    end
  end
end

# ----------------------------------------------------------
# 中央値の算出
# ----------------------------------------------------------
class Array
  def median
    array = self.sort
    mid, mod = size.divmod(2)
    if mod == 0
      array[mid - 1, 2].inject(:+) / 2.0
    else
      array[mid]
    end
  end
end

# ----------------------------------------------------------
# 並列アクセス
# ----------------------------------------------------------
def ParallelAccess(urilist)
  response_time = []
  Parallel.each(urilist, in_threads: 100) {|uri|
    begin
      res = Net::HTTP.get_response(uri)
      body = res.body if res.is_a?(Net::HTTPSuccess)
      response_time.push(body)
    rescue => ex
      puts ex
    end
  }
  
  # ミリ秒が返却されるので平均値を求めて返却
  return response_time.inject(0){|sum,x| sum.to_i + x.to_i }/response_time.size
end

# ----------------------------------------------------------
# パターン作成
# ----------------------------------------------------------
def random(i)
  (("a".."z").to_a + (0..9).to_a).shuffle[0..i].join
end

def CreateItem(count)
  items = []
  count.times do
    items.push(random(8))
  end
  return items
end

# ----------------------------------------------------------
# ベンチマーク
# ----------------------------------------------------------
file = File::open('result_' + Time.now.to_i.to_s + ".csv" ,'a:windows-31j')

# URL取得
#webs = get_webs
webs = bench_pattern ARGV[0]

# 試行回数(1,2,3,5,8,13,21,34,55,89)
#running_counts = [1,2,3,5,8,13,21,34,55,89]
running_counts = [1,2,3,5,8,13,21,34,55,89]

running_counts.each do |r|
  file.write(",#{r}回")
  file.write("\n") if r == running_counts.last
end

# アイテム数(10,20,30,50,80,100,130,200,400,800)
item_counts = [10,20,30,50,80,100,130,200,400,800]
#item_counts = [800]


# アイテム数分繰り返し
item_counts.each do |ic|
  #through_put_array = []
  file.write("#{ic}個,")
  
  # 試行回数分繰り返し
  running_counts.each do |i|
    print "\n#{ic}個を#{i}回試行"
    
    # 200回繰り返してノイズ低減
    average = 0
    noise_reduction_arr = []
    5.times do |n|
      print "\nノイズ低減用 #{n+1}回目 "
      # キャッシュクリア
      CacheCrear(webs)
      
      # アイテム作成
      items = CreateItem(ic)
      
      # 同じアイテムセットの繰り返し
      avr_arr = []
      print "#{i}:"
      (i).times do |j|
        # 100リクエスト
        urilist = []
        100.times do
          urilist.push(URI.parse(webs[rand(webs.size)] + items[rand(items.size)]))
        end
        
        avr_arr.push(ParallelAccess(urilist))
        print "■"
      end
      
      # 同じセット内の平均値算出
      noise_reduction_arr.push( avr_arr.inject(0){|sum,x| sum.to_i + x.to_i }/avr_arr.size )
      
      # 中央値のほうがよい？？→ダメ。同じセット内では全体のスループットで計測すべき。
      #noise_reduction_arr.push( avr_arr.median )
    end
    
    # ノイズ低減用に中央値算出
    #through_put_array.push(noise_reduction_arr.median)
    file.write(noise_reduction_arr.median)
    file.write(",") unless i == running_counts.last
  end
  
  file.write("\n")
end



__END__
