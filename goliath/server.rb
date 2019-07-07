#!/usr/bin/env ruby
# Usage: ./server.rb -sv -p 9999
require 'goliath'
require 'net/http'
require 'em-http-request'

class Server < Goliath::API
  def response(env)
    if env["REQUEST_PATH"] == '/tick'  
      [200, {}, "tick"]
    elsif env["REQUEST_PATH"] == '/fast' 
      res = Net::HTTP.get_response(URI('http://localhost:8888/fast'))
      [200, {}, "#{res.body}"]
    elsif env["REQUEST_PATH"] == '/lazy'  
      EventMachine.run {
        http = EventMachine::HttpRequest.new("http://localhost:8888/lazy").get :query => {'keyname' => 'value'}

        http.errback { 'Uh oh'; EM.stop }
        http.callback {
         # p http.response_header.status
         # p http.response_header
         # p http.response

          [200, {}, "#{http.response}"]
          EventMachine.stop
        }
      }
      #[200, {}, "#{http.body}"]
    else
      [404, {}, "Not Found!"]
    end
  end


end
