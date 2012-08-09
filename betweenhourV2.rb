class BetweenHour
  def isBetweenHour(beginHour, endHour, checkHour)
    # 受け取った値が数値か確認
    if (beginHour.class != Fixnum || endHour.class != Fixnum || checkHour.class != Fixnum)
      raise
    end
    
    # 範囲外の値を指定した場合エラー
    if (beginHour >= 24 || endHour >= 24 || checkHour >= 24 || beginHour < 0 || endHour < 0 || checkHour < 0)
      raise
    end
    
    # 開始時刻と終了時刻が同じ場合は含まれる
    if (beginHour == checkHour && checkHour == endHour)
      return true
    end
    
    # 時間をループさせ、その中にcheckHourがあるかどうかを確認する処理にした
    until beginHour == endHour
      if (checkHour == beginHour)
        return true
      end
      
      if beginHour >= 23
        beginHour = 23 - beginHour
      else
        beginHour = beginHour + 1
      end
    end
    
    return false
  end
end

