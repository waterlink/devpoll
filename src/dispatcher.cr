require "./handlers/*"

module Devpoll
  class Dispatcher < HTTP::Handler
    HANDLERS = [
      Handlers::Home,
      Handlers::GetPoll,
      Handlers::PostAnswer,
      Handlers::NotFound,
    ]

    def call(request)
      handler(request.method, request.path)
        .new(request)
        .call
    end

    def handler(method, path)
      HANDLERS.find(&.matches?(method, path)).not_nil!
    end
  end
end
