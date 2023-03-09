class UsersController < ApplicationController
  # POST /users
  def create
    user = User.new(user_params)

    if user.save
      render json: UserBlueprint.render(user, with_token: true), status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/login
  def login
    user = User.find_by(email: user_params.fetch(:email))&.authenticate(user_params.fetch(:password))
    if user
      render json: UserBlueprint.render(user, with_token: true)
    else
      render json: { login: ['invalid email or password'] }, status: :unauthorized
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:firstname, :lastname, :email, :password)
    end
end
