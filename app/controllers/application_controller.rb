class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :redirect_https, :authenticate_user!

  include Jpmobile::ViewSelector

  def redirect_https
    if Rails.env == "production"
      redirect_to :protocol => "https://" unless request.ssl?
      return true
    end
  end
end
