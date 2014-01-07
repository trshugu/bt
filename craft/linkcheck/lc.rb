#!ruby
# coding: utf-8

require "net/http"
require "uri"
require "parallel"
require "logger"

require "./checklinkmodule.rb"
extend Checklink

log = Logger.new("log.txt")
log.progname = "lc"
log.level = Logger::DEBUG

# テキストを読み込む
#file = $0.gsub("rb", "txt").split("/").pop
file = ARGV[0]
if file == nil
  log.debug("argv nothing");
  exit
end

until File.exist?(file)
  log.debug("file nothing");
  exit
end

# 結果ファイル名(同じファイル名が存在していたら削除)
resultfile = "zzresultrb_" + file
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
#File::open(resultfile, "a").write(urilist.size.to_s + "件\n")
File::open(resultfile, "a").write(urilist.size.to_s + "件\n")
log.info(file + ":" + urilist.size.to_s + " count");

# -----------------------------------------------------------------------------
# URIチェック
# -----------------------------------------------------------------------------

=begin
# ノンスレッド
starttime = Time.now
urilist.each do |uri|
  log.debug(uri);
  checked_uri = check_uri(uri)
  log.debug(checked_uri);
  File::open(resultfile, "a").write(checked_uri)
end
nonthreadtime = (Time.now - starttime).to_f.to_s
=end

=begin
# 一行読んでスレッドへ渡す
starttime = Time.now
threads = []
urilist.each do |uri|
  threads << Thread.new do
    log.debug(uri);
    checked_uri = check_uri(uri)
    log.debug(checked_uri);
    File::open(resultfile, "a").write(checked_uri)
  end
end

# 全スレッドの終了を待つ
threads.each do |thread|
  thread.join
end
threadtime = (Time.now - starttime).to_f.to_s
=end


# Parallelの使用
starttime = Time.now
Parallel.each(urilist, in_threads: 80) {|uri|
  log.debug(uri);
  checked_uri = check_uri(uri)
  log.debug(checked_uri);
  File::open(resultfile, "a").write(checked_uri)
}
paralleltime = (Time.now - starttime).to_f.to_s
=begin
=end





# 計測終了
#File::open("linklog.txt", "a").write((Time.now - starttime).to_f.to_s + "\n")
#log.info(nonthreadtime);
#log.info(threadtime);
log.info(paralleltime);



