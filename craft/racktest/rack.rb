module Rerack
  extend self
  
  def call(env)
    #p env
    case env['REQUEST_METHOD']
      when 'GET'
        [
          200,
          { 'Content-Type' => 'text/html;charset=utf-8' },
          ['<html><body><form method="POST"><input type="submit" value="submi" />loook？</form></body></html>']
        ]
      when 'POST'
        [
          200,
          { 'Content-Type' => 'text/html;charset=utf-8' },
          ['<html><body>asfasdfbaboon</body></html>']
        ]
    end
  end
  
end


