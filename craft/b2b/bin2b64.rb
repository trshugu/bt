#!ruby
# -*- coding: utf-8 -*-
# 対象ファイルを読込バイナリで開き、pack('m')でBase64にし出力先に書きこむ
require 'pathname'
open(Pathname(ARGF.filename).sub_ext(".txt").to_s, "w").write([open(ARGF.filename, "rb").read].pack('m'))



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
