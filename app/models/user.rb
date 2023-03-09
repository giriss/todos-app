class User < ApplicationRecord
  has_secure_password
  validates :firstname, :lastname, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }

  SECRET = Rails.application.credentials.secret_key_base

  def token
    JWT.encode({ exp: 2.hours.from_now.to_i, user_id: id }, SECRET)
  end

  def self.find_from_token(token)
    id = JWT.decode(token, SECRET)[0]['user_id']
    find(id)
  rescue JWT::DecodeError
    nil
  end
end
