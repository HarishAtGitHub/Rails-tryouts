Rails.application.routes.draw do
  # we follow the convention that all urls will have this prefix to indicate two things
  #1. it is an ctf iaf app
  #2. it is a binary type multiplexer

  scope '/ctf-iaf/binary' do
    resource :repositories
  end

  namespace :services do
    namespace :team_forge , defaults: { format: :xml } do
      get '/ConfigurationParameters/:token/:tf_project_id' => :get_configuration_parameters

      post '/ProjectConfiguration/:token' => :create_project_configuration
      put '/ProjectConfiguration/:token' => :update_project_configuration
      delete '/ProjectConfiguration/:token/:tf_project_id' => :delete_project_configuration

      get '/ProjectId/:token/:object_id' => :get_ctf_project_id
      get '/Title/:token/:object_id' => :get_title

    end
  end
end
