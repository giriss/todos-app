class ApplicationController < ActionController::API
  before_action :preload_user

  attr_reader :current_user

  def preload_user
    auth_token = request.headers['Authorization']&.sub('Bearer ', '')
    @current_user = User.find_from_token(auth_token)
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end

  def authenticate
    render json: { token: ['is invalid or has expired'] }, status: :unauthorized unless @current_user
  end
end
