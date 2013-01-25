class Fibonacci
  def fibonacci
    beforeTwo = 0
    beforeOne = 0
    beforeZero = 1
    return -> {
      beforeTwo = beforeOne
      beforeOne = beforeZero
      beforeZero = beforeOne + beforeTwo
      beforeOne
    }
  end
  
  def returnFibonacciNumber(numberInt)
    # 受け取った値が数値か確認
    raise if numberInt.class != Fixnum
    
    result = 0
    f = fibonacci
    numberInt.times do
      result = f.call
    end
    
    return result
  end
end

puts Fibonacci.new().returnFibonacciNumber ARGV[0].to_i
