kind = 2
count = 3

allcmb = kind ** count

expcmb = 1
kind.downto(1) do |i|
  expcmb = expcmb * i
end

puts "expcmb:" + expcmb.to_s
exp = expcmb * (kind **  (count - kind))

puts "all:"+allcmb.to_s
puts "get:"+exp.to_s

par = sprintf( "%.12f", (exp.to_f/allcmb.to_f)*100)
puts par

