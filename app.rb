#!/usr/bin/env ruby
require 'sinatra'

get '/:status' do
  status "#{params[:status]}"
  "Your status is #{params[:status]}"
end
