class ApplicationController < ActionController::Base
  # null_session instead of :exception bc we don't have an authenticity token and rails expects us to always have a token when giving/receiving data
  protect_from_forgery with: :null_session
end
