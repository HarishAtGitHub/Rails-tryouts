class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    if params[:sfProj] && params[:sfLoginToken] && params[:isLoggedIn]
      p "works"
    end
  end
end
