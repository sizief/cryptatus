#!/usr/bin/env ruby
# Usage: ./server.rb -sv -p 9999 -e production

require 'net/http'
require 'goliath'

class Server < Goliath::API
  def response(env)
    if env["REQUEST_PATH"] == '/tick'
      [200, {}, "tick"]
    elsif env["REQUEST_PATH"] == '/fast'
      uri = URI('http://localhost:8888/fast')
      res = Net::HTTP.get_response(uri)
      [200, {}, "#{res.code}: #{res.body}"]
    elsif env["REQUEST_PATH"] == '/lazy'
      uri = URI('http://localhost:8888/lazy')
      res = Net::HTTP.get_response(uri)
      [200, {}, "#{res.code}: #{res.body}"]
    else
      [404, {}, "not found"]
    end
  end
end
