require 'rubygems'
require 'app.rb'
set :run, false
set :environment, :production
run Sinatra::Application