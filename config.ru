require 'rubygems'
require 'sinatra'
require 'cgi'
require 'estate'

map '/' do
  run App
end