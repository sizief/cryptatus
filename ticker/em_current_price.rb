require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'
require 'em-http-request'

class Handler  < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new( self )
    
    if @http_request_uri == '/tick'
      puts "#{CurrentPrice.number} at #{Time.now}"
      resp.content = CurrentPrice.number
      resp.status = 200
    else
      resp.content = '404'
      resp.status = '404'
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
    http = EM::HttpRequest.new('http://pricer:8080/tick').get
    http.callback { @number = http.response;}
    http.errback {p http.error }
  end
end

EventMachine::run {
  EventMachine.add_periodic_timer(1) { CurrentPrice.update}
  EventMachine::start_server("0.0.0.0", 8080, Handler)
}

