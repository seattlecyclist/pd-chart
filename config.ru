require 'sinatra/base'
require 'sprockets'
require 'sass'
require 'pipeline_deals'
require './app/services/pipeline/deals.rb'

Dir.glob('./app/{services,controllers}/*.rb').each { |file| require file }

map('/') { run DealsController }

