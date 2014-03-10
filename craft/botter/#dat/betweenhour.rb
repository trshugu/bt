class BetweenHour
  # ある時刻(0時～23時)が、指定した時間の範囲内に含まれるかどうかを調べる
  def isBetweenHour(beginHour, endHour, checkHour)
    # 受け取った値が数値か確認
    if (beginHour.class != Fixnum || endHour.class != Fixnum || checkHour.class != Fixnum)
      raise
    end
    
    # 24以上の値を指定した場合エラー
    if (beginHour >= 24 || endHour >= 24 || checkHour >= 24)
      raise
    end
    
    # 日付型へ変換
    beginHour = Time.gm(0,1,1,beginHour)
    endHour = Time.gm(0,1,1,endHour)
    checkHour = Time.gm(0,1,1,checkHour)
    
    # 開始時刻と終了時刻が同じ場合は含まれる
    if (beginHour == checkHour && checkHour == endHour)
      return true
    end
    
    # 開始時刻が終了時刻より大きい場合日跨ぎ判定
    if (beginHour > endHour)
      endHour = Time.gm(0,1,endHour.day + 1, endHour.hour)
      
      # 開始時刻が判定時刻より大きい場合日跨ぎ判定
      if (beginHour > checkHour)
        checkHour = Time.gm(0,1,checkHour.day + 1, checkHour.hour)
      end
    end

    # 範囲指定は開始時刻を含み終了時刻は含まない
    if (beginHour <= checkHour && checkHour < endHour)
      return true
    end
    
    return false
  end
end
