# n番目のフィボナッチ数を返却する
class Fibonacci
  # 初期値は0と1
  def initialize
    @beforeTwo = 0
    @beforeOne = 1
  end

  def returnFibonacciNumber(numberInt)
    # 受け取った値が数値か確認
    raise if numberInt.class != Fixnum
    
    # 0の場合は0、1の場合は1を返却
    return numberInt if numberInt <= 1
    
    if (numberInt > 2)
      sumNum = @beforeOne + @beforeTwo
      @beforeTwo = @beforeOne
      @beforeOne = sumNum
      return returnFibonacciNumber(numberInt-1)
    else
      return @beforeOne + @beforeTwo
    end
  end

end

puts Fibonacci.new().returnFibonacciNumber(ARGV[0].to_i)
