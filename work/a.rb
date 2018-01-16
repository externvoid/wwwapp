require 'json'
a = JSON.load('{"foo": "bar"}', symbolize_names: true) 
puts a
