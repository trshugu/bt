require "net/http"
require "uri"

#存在確認も必要・・・
#＜要件＞
#□生存チェック
#□重複チェック
#□フィルタリング
#□ソート
#□削除、追加などの編集

#2012/08/15 10:24 一斉にアクセスして確認するスレッドな高速化

#＊同じ名前のテキストを読み込む
file = $0.gsub("rb", "txt").split("/").pop

#＊結果ファイル名
resultfile = "resultrb_" + file

File.readlines(file).each do |line|
  if /^http/ =~ line
    begin
      #URLの取得
      response = Net::HTTP.get_response(URI.parse(line))
      case response
        when Net::HTTPSuccess, Net::HTTPRedirection
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
