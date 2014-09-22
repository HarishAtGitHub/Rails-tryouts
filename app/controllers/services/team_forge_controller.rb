class Services::TeamForgeController < ApplicationController
  #switching it off as it is a controller for api call
  protect_from_forgery with: :null_session
  before_action :authenticate_iaf_api

  def get_configuration_parameters
    render :configuration_parameters
  end

  def create_project_configuration
    head :no_content
  end

  def update_project_configuration
    head :no_content
  end

  def delete_project_configuration
    head :no_content
  end

  def get_ctf_project_id
    @ctf_project_id = 'proj1001'
    render :ctf_project_id
  end

  def get_title
    @title = 'I am title'
    render :title
  end

end
