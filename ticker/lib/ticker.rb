require 'eventmachine'
require 'evma_httpserver'
require 'em-http-request'

PRICER_SERVER = ARGV[0] #'http://localhost:8080'

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
    abort("Aborting. Pricing server is not provided.") if PRICER_SERVER.nil?
    @number ||= 1000

    http = EM::HttpRequest.new(PRICER_SERVER).get
    http.callback { @number = http.response;}
    http.errback {p http.error }
  end
end

EventMachine::run {
  EventMachine.add_periodic_timer(1) { CurrentPrice.update} 
  EventMachine::start_server("0.0.0.0", 8080, Handler)
}
