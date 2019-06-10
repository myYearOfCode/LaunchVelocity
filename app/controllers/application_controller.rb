class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :set_csrf_cookie

protected
  def set_csrf_cookie
    cookies["X-CSRF-Token"] = form_authenticity_token
  end
end
