require 'rubygems'
require 'sinatra'
require 'cgi'
require 'app'
require 'estate'

map '/' do
  run App
end