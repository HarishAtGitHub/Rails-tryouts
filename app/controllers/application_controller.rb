require 'teamforge'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  @@ctf_host_url = Rails.configuration.CTF_HOST_URL
  TeamForge.server = @@ctf_host_url
  TeamForge.use_ssl = @@ctf_host_url.start_with?('https:')

=begin
   Authenticates the request against teamforge .
   Use the existing session if the session is valid .
   In cases of
   1. invalid session
   2. unexpected error in session validation (may be due to failure of some other case)
   3. session itself does not exist for that request yet

   try the token based authentication.
   If token based authentication also fails, redirect him
   to teamforge '/sf/sfmain/do/login' page.
=end
  protected
    def authenticate
      Rails.logger.debug 'Authenticating the request...'


      begin
        if session['ctf_session']
          begin
            authenticate_with_session_id
          rescue TeamForge::TeamForgeError => e
            authenticate_with_token
          end
        else
          authenticate_with_token
        end
      rescue TeamForge::TeamForgeError => e
          Rails.logger.debug 'SOAP Call Failed so redirecting to teamforge'
          Rails.logger.debug e.message
          redirect_to teamforge_login_url
      rescue => e
        Rails.logger.debug 'Authentication Failed so redirecting to teamforge'
        Rails.logger.debug e.message
        redirect_to teamforge_login_url
      end
    end

  private
    def authenticate_with_token
      ctf_project_url_name = params[:sfProj]
      ctf_project_path = 'projects.' + ctf_project_url_name
      ctf_session = TeamForge::GetSessionId.new(params[:sfLoginToken]).request
      @ctf_prpl_id = TeamForge::PluggableApp::GetLinkPlugId.new(ctf_session , ctf_project_path, Rails.configuration.IAF_BASE_URL ).request
      userDO = TeamForge::GetCurrentUserData.new(ctf_session).request
      @username = userDO.username
      session['ctf_session'] = ctf_session
      @ctf_iframe_url = get_iframe_url ctf_project_path, @ctf_prpl_id
    end

  private
    def authenticate_with_session_id
      ctf_project_url_name = params[:sfProj]
      ctf_project_path = 'projects.' + ctf_project_url_name
      @ctf_prpl_id = TeamForge::PluggableApp::GetLinkPlugId.new(session[:ctf_session] , ctf_project_path, Rails.configuration.IAF_BASE_URL ).request
      @ctf_iframe_url = get_iframe_url ctf_project_path, @ctf_prpl_id
      userDO = TeamForge::GetCurrentUserData.new(session[:ctf_session]).request
      @username = userDO.username
    end

  protected
    def authenticate_iaf_api
      TeamForge::GetSessionId.new(params[:token]).request
    end

  def get_iframe_url ctf_project_path, ctf_prpl_id
    @@ctf_host_url + '/sf/sfmain/do/topInclude/' + ctf_project_path + '?linkId=' + ctf_prpl_id
  end

  def teamforge_login_url
    @@ctf_host_url + '/sf/sfmain/do/login'
  end

end