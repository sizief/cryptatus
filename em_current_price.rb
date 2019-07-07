require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'
require 'em-synchrony'
require 'em-synchrony/em-http'

class Handler  < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new( self )
    resp.status = 200
    
    if @http_request_uri == '/tick'
      resp.content = CurrentPrice.number
   # elsif @http_request_uri == '/test' 
   #   http = EM::HttpRequest.new('http://localhost:8888/price').aget
   #   http.callback {resp.content = http.response}
    else
      resp.content = '404'
    end
      
    resp.send_response
  end

end

class CurrentPrice
  def self.number
    @number
  end

  def self.update
    @number ||= 1000
    http = EM::HttpRequest.new('http://localhost:8888/price').aget
    http.callback { @number = http.response}
  end
end

EventMachine::run {
  EventMachine.add_periodic_timer(1) { CurrentPrice.update}
  EventMachine::start_server("0.0.0.0", 8080, Handler)
}

