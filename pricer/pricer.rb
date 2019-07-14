#  ./lazy.rb  -p 8888 -e production

require 'sinatra'
require "sinatra/json"

get '/fast' do
  json :body => "I am fast", :pid => Process.pid, :tid => Thread.current.object_id
end	

get '/lazy' do
  sleep 5 #do_hard_work
  "I am lazy"
end

get '/tick' do
  Time.now.to_i.to_s
end
