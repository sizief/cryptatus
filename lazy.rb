#!/usr/bin/env ruby

#  ./lazy.rb  -p 8888 -e production

require 'sinatra'
require "sinatra/json"

get '/fast' do
  json :body => "I am fast", :pid => Process.pid, :tid => Thread.current.object_id
end	

get '/lazy' do
  sleep 2 #do_hard_work
  json :body => "I am lazy", :pid => Process.pid , :tid => Thread.current.object_id
end

get '/price' do
	Time.now.to_i.to_s
end
