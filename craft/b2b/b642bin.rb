#!ruby
# -*- coding: utf-8 -*-
# 対象ファイルを開き、unpack('m')[0]でバイナリにし出力先に書きこむ
require 'pathname'
open(Pathname(ARGF.filename).sub_ext(".bin").to_s, "wb").write(File.read(ARGF.filename, :encoding => Encoding::UTF_8).unpack('m')[0])



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
