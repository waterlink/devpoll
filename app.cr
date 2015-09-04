require "./src/devpoll"

Devpoll::Server.new((ENV["PORT"]? || 8080).to_i).start
