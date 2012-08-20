#!ruby
# -*- coding: utf-8 -*-
#!ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'atomutil'

username = ''
password = ''
auth = Atompub::Auth::Wsse.new :username => username, :password => password
client = Atompub::Client.new :auth => auth
collection_uri = 'http://d.hatena.ne.jp/%s/atom/blog' % username

title = ""
content = <<-EOF
EOF

entry = Atom::Entry.new
entry.title = title.encode('BINARY', 'BINARY')
entry.content = content.encode('BINARY', 'BINARY')
entry.updated = Time.now

puts client.create_entry collection_uri, entry






=begin

POST /agileronin/atom/blog

<?xml version="1.0" encoding="utf-8"?>
<entry xmlns="http://purl.org/atom/ns#">
  <title>日記エントリータイトル</title>
  <content type="text/plain">
日記エントリー本文
- はてな
- 記法
  </content>
</entry>

=end


http://rubyforge.org/projects/hatenaapiauth/





=begin

require 'rubygems'
require 'atomutil'

module Atompub
  class HatenaClient < Client
    def publish_entry(uri)
      @hatena_publish = true
      update_resource(uri, ' ', Atom::MediaType::ENTRY.to_s)
    ensure
      @hatena_publish = false
    end
    
    private
    def set_common_info(req)
      req['X-Hatena-Publish'] = 1 if @hatena_publish
      super(req)
    end
  end
end


auth = Atompub::Auth::Wsse.new :username => '', :password => ''
client = Atompub::HatenaClient.new :auth => auth
service = client.get_service 'http://d.hatena.ne.jp//atom'
collection_uri = service.workspace.collections[1].href

entry = Atom::Entry.new(
  :title => 'てすと',
  :updated => Time.now
)

puts client.create_entry collection_uri, entry
=end


