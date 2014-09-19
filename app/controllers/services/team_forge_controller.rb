class Services::TeamForgeController < ApplicationController
  #switching it off as it is an api call (need to study more)
  protect_from_forgery with: :null_session

  def get_configuration_parameters
    render "configuration_parameters"
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
    render 'ctf_project_id'
  end

  def get_title
    @title = 'I am title'
    render 'title'
  end

end
