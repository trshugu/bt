#(kind, count) k=<c

=begin
list = []
2.times do |i|
  2.times do |j|
    line = []
    line.push(i).push(j)
    #list.push(line)
    p line
  end
end

p list
=end

=begin
# クラスで
class Nameko
  
  def returnLine(kind)
    kind.times do |i|
      puts i
      puts returnNum(kind)
    end
    return "end"
  end

  def returnNum(num)
    num.times do |j|
      return j
    end
  end

=end

#p Nameko.new.returnLine(3)

kind = 3
list = []

kind.times do |i|
  line = []
  line.push(i)
  list.push(line)
end

list.each do |l|
  kind.times do |j|
    l.push(j)
  end
end


=begin
a=[]
b=[]
p a.push(0).push(1)
p b.push(a).push(a)
b.each do |i|
  p i
=end




