require "./handlers/*"

module Devpoll
  class Dispatcher < HTTP::Handler
    HANDLERS = [
      Handlers::Home,
      Handlers::GetPoll,
      Handlers::PostAnswer,
    ]

    def call(request)
      if h = handler(request.method, request.path)
        return h.new(request).call
      end

      call_next(request)
    end

    def handler(method, path)
      HANDLERS.find(&.matches?(method, path))
    end
  end
end
