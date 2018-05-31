class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user_with_token_and_cookie

  private
    def authenticate_user_with_token_and_cookie
      authenticate_user!
    end
end
