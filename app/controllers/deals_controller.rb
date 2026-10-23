class DealsController < ApplicationController
  set :environment, Sprockets::Environment.new
  environment.append_path "assets/javascripts"
  environment.append_path "assets/stylesheets"
  environment.css_compressor = :scss

  get '/' do
    service = Pipeline::Deals.new
    @max_total = service.max_total
    @totals = service.stage_totals

    erb :index
  end

end