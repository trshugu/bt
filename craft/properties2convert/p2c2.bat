ruby -pne "$_.scan(/(\\u[\w\d]{4})/).each{|utf|$_.sub!(utf[0],(utf[0][2,4]).to_i(16).chr('UTF-8'))}" %1 >> %1.txt
