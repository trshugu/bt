class Fibonacci
  # n番目のフィボナッチ数を返却する
  def returnFibonacciNumber(numberInt)
    # 受け取った値が数値か確認
    if (numberInt.class != Fixnum)
      raise
    end
    
    beforeOne = 0
    beforeTwo = 0
    resultFibonacciNumber = 1
    
    numberInt.times do
      beforeTwo = beforeOne
      beforeOne = resultFibonacciNumber
      resultFibonacciNumber = beforeOne + beforeTwo
    end
    
    return resultFibonacciNumber
  end
end

# 1番目は0で2番目は1なので微妙に違う。
# あと再帰関数でやるべき