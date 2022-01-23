class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from Pundit::NotAuthorizedError, StandardError, :with => :error_response

  private

  alias current_user current_api_user

  def error_response(e)
    render json: { error: e.message }, status: 400
  end
end
