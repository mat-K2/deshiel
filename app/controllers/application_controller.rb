class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :redirect_https

  include Jpmobile::ViewSelector

  def redirect_https
    if Rails.env == "production"
      redirect_to :protocol => "https://" unless request.ssl?
      return true
    end
  end

  def current_user
    current_user = User.find_by_email("yamada@test.com")
  end
end
