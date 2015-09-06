module Devpoll
  class Server
    getter port, server
    def initialize(@port)
      @server = HTTP::Server.new(port, [
        HTTP::LogHandler.new,
        HTTP::ErrorHandler.new,
        Dispatcher.new,
        HTTP::StaticFileHandler.new("./src/public/"),
      ])
    end

    def start
      @server.listen
    end
  end
end
