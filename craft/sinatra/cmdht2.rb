#!ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'atomutil'

username = ''
password = ''
auth = Atompub::Auth::Wsse.new :username => username, :password => password
client = Atompub::Client.new :auth => auth
collection_uri = 'http://d.hatena.ne.jp/%s/atom/blog' % username

title = "あ"
content = <<-EOF
EOF

entry = Atom::Entry.new
entry.title = title.encode('BINARY', 'BINARY')
entry.content = content.encode('BINARY', 'BINARY')
entry.updated = Time.now

puts client.create_entry collection_uri, entry

