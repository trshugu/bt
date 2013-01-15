# 文字列を返すだけのクラスを参照するクラス。
# 自分の居場所(__FILE__)からパスを展開する。
require File.expand_path('../retstr.rb', __FILE__)

class Bo
  def getter
    concre = Retstr.new
    puts concre.stringer
  end
end

