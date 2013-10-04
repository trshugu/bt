require "json"
require 'couchbase'

head = ARGF.first.split("\t")
head.shift
list = []
line = nil
ARGF.each{|l|
  llist = l.strip.split("\t")
  id = llist.shift
  value = head.zip(llist).inject({}){|h,x| h[x[0]]=x[1];h}
  line = Hash[id , value]
  list.push(line)
}

client = Couchbase.connect(:bucket => "ticket", :hostname => "192.168.xx.xx", :username => 'user', :password => 'pass')
list.each{|line|
  begin
    client.set(line)
  rescue => ex
    p ex
  end
}
client.disconnect


