class ApplicationController < ActionController::Base
  require 'rest-client'
  require 'json'

  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
