commands = [
"gem install bundle --no-ri --no-rdoc",
"gem install twitter --no-ri --no-rdoc",
"gem install rake --no-ri --no-rdoc",
"gem install rspec --no-ri --no-rdoc",
"gem install rails --no-ri --no-rdoc",
"gem install cucumber --no-ri --no-rdoc",
"gem install pik --no-ri --no-rdoc",
"gem install sinatra --no-ri --no-rdoc",
"gem install capistrano --no-ri --no-rdoc",
"gem install atomutil --no-ri --no-rdoc"
]

commands.each do |command|
  system("#{command}")
end
