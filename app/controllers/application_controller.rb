class ApplicationController < ActionController::Base
  include Application

  private

  def save_my_previous_url
    previous_url = request.referer
    session[:my_previous_url] = previous_url unless previous_url == request.url
  end
end
