class ApplicationController < ActionController::Base
  require 'rest-client'
  require 'json'
  
  protect_from_forgery with: :exception
end
