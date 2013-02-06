class Fibonacci
  def fib(n)
    i1,i2 = 0,1
    n.times do
      i1, i2 = i2, i1+i2
    end
    i1
  end
  
  def returnFibonacciNumber(n)
    fib(n)
  end
end

puts Fibonacci.new().returnFibonacciNumber ARGV[0].to_i
