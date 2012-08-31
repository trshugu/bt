require "net/http"
require "uri"

# 計測開始
#starttime = Time.now

# 同じ名前のテキストを読み込む
file = $0.gsub("rb", "txt").split("/").pop

# 結果ファイル名(同じファイル名が存在していたら削除)
resultfile = "resultrb_" + file
if File.exist?(resultfile)
  File.delete(resultfile)
end

# uriを抽出しリストに格納
urilist = []
File.readlines(file).each do |line|
  if /^http/ =~ line
    urilist << line
  end
end

# URIチェック(スレッド化され並列処理される)
def checkuri(uri)
  begin
    response = Net::HTTP.get_response(URI.parse(uri))
    case response
      when Net::HTTPSuccess, Net::HTTPRedirection
        return
      else
        return uri.chomp + " " + response.code + "\n"
    end
  rescue
    return uri
  end
end

# 一行読んでスレッドへ渡す
threads = []
urilist.each do |uri|
  threads << Thread.new do
    File::open(resultfile, "a").write(checkuri(uri))
  end
end

# 全スレッドの終了を待つ
threads.each do |thread|
  thread.join
end

# 計測終了
#File::open("linklog.txt", "a").write((Time.now - starttime).to_f.to_s + "\n")

