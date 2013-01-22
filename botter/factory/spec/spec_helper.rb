# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..')) # 対象のdir
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'bot')) # 対象のdir

require 'rspec'
require 'bot' # 対象のクラス
require 'assets/betweenhour' # 対象のクラス
