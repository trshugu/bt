#!ruby
# coding: utf-8

require "net/http"
require "uri"
require "./checklinkmodule.rb"

# 計測開始
starttime = Time.now

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
    urilist << line.chomp
  end
end

# 総件数
File::open(resultfile, "a").write(urilist.size.to_s + "件\n")

# 一行読んでスレッドへ渡す
checklink = Checklink.new()
threads = []
urilist.each do |uri|
  threads << Thread.new do
    File::open(resultfile, "a").write(checklink.checkuri(uri))
  end
end

# 全スレッドの終了を待つ
threads.each do |thread|
  thread.join
end

# 計測終了
File::open("linklog.txt", "a").write((Time.now - starttime).to_f.to_s + "\n")
