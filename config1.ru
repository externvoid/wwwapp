require '/home/pi/wwwapp/server.rb'
log = File.new("logs/std.log", "a+")
def STDOUT.write string
    log.write string
    super
end
STDOUT.sync = true
run Sinatra::Application
