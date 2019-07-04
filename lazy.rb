#!/usr/bin/env ruby

# Usage: ./lazy.rb -sv -p 8888 -e production

require 'goliath'

class Lazy < Goliath::API
  def response(env)
    if env["REQUEST_PATH"] == '/fast'
      [200, {}, "I am FAST!"]
    elsif env["REQUEST_PATH"] == '/lazy'
      do_hard_work
      [200, {}, "I am lazy"]
    else
      [404, {}, "Not found"]
    end
  end

  def do_hard_work
    arr = []
    (0..200_000_000).each {|i| arr.push i}
  end
end
