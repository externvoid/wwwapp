#require '/home/pi/wwwapp/server.rb'
#puts File.expand_path('./server.rb', __FILE__)

# require File.expand_path('../server.rb', __FILE__)
require_relative 'server'
run Sinatra::Application
