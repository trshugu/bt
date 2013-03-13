commands = [
"gem install bundle --no-ri --no-rdoc",
"gem install twitter --no-ri --no-rdoc",
"gem install rake --no-ri --no-rdoc",
"gem install rspec --no-ri --no-rdoc",
"gem install rails --no-ri --no-rdoc",
"gem install cucumber --no-ri --no-rdoc",
"gem install sinatra --no-ri --no-rdoc",
"gem install capistrano --no-ri --no-rdoc",
"gem install atomutil --no-ri --no-rdoc",
"gem install execjs --no-ri --no-rdoc",
"gem install uglifier --no-ri --no-rdoc",
"gem install jquery-rails --no-ri --no-rdoc",
"gem install sqlite3 --no-ri --no-rdoc",
"gem install sass --no-ri --no-rdoc",
"gem install sass-rails --no-ri --no-rdoc",
"gem install coffee-script --no-ri --no-rdoc",
"gem install coffee-script-source --no-ri --no-rdoc",
"gem install coffee-rails --no-ri --no-rdoc",
"gem install redcar --no-ri --no-rdoc",
"gem install json --no-ri --no-rdoc",
"gem install heroku --no-ri --no-rdoc",
"gem install vagrant --no-ri --no-rdoc",
"gem install ruby-debug-base19x --no-ri --no-rdoc"
]

commands.each do |command|
  system("#{command}")
end
