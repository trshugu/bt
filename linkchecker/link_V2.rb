require "net/http"
require "uri"

# 計測開始
#starttime = Time.now

# 同じ名前のテキストを読み込む
file = $0.gsub("rb", "txt").split("/").pop

# 結果ファイル名
resultfile = "resultrb_" + file

# チェック処理をスレッド化
def checkuri(line)
  if /^http/ =~ line
    begin
      #URLの取得
      response = Net::HTTP.get_response(URI.parse(line))
      case response
        when Net::HTTPSuccess, Net::HTTPRedirection
          return
        else
          return line.chomp + " " + response.code + "\n"
      end
    rescue
      return line
    end
  end
end

# 一行読んでスレッドへ渡す
threads = []
File.readlines(file).each do |line|
  threads.push(Thread.new { result = checkuri(line);open(resultfile, "a+").write(result); })
end

# 全スレッドの終了を待つ
threads.each {|t| t.join}

# 計測終了
#File::open("linklog.txt", "a").write((Time.now - starttime).to_f.to_s + "\n")

