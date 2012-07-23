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
