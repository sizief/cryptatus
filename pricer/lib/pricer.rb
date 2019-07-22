#!/usr/bin/env ruby
#run me:  ./lib/pricer.rb

require 'sinatra'
require "sinatra/json"
require 'yaml'

# config = YAML.load_file("#{File.expand_path(File.dirname(__FILE__))}/../../container_config.yml")

set :port, 8080 #config['containers']['pricer']['port']
set :environment, 'production' #config['containers']['pricer']['environment']

get '/fast' do
  json :body => "I am fast", :pid => Process.pid, :tid => Thread.current.object_id
end	

get '/lazy' do
  sleep 5 #do_hard_work
  "I am lazy"
end

get '/price' do
  Time.now.to_i.to_s
end
