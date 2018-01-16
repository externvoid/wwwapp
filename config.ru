#require '/home/pi/wwwapp/server.rb'
require File.expand_path('../server.rb', __FILE__)
#puts File.expand_path('./server.rb', __FILE__)
run Sinatra::Application
