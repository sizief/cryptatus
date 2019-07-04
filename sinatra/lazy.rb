#!/usr/bin/env ruby

# Usage: ./lazy.rb -sv -p 8888 -e production

require 'sinatra'
require "sinatra/json"

get '/fast' do
  json :body => "I am fast", :pid => Process.pid, :tid => Thread.current.object_id
end	

get '/lazy' do
  sleep 10 #do_hard_work
  json :body => "I am lazy", :pid => Process.pid , :tid => Thread.current.object_id
end

def do_hard_work
  arr = []
  (0..200_000_000).each {|i| arr.push i}
end
