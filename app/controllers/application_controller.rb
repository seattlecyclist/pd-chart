class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)

  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.environment.call(env)
  end

end