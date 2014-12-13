class CustomAuthenticationFailure < Devise::FailureApp
  protected

  def redirect_url
    home_path
  end
end
