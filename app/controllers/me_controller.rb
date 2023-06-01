require 'jwt'

class MeController < ApplicationController
  def profile
    payload = decodeSignedJwtToken(getBearerToken()).first
    user = User.where(provider: payload["provider"], username: payload["username"]).first
    render json: user
  end

  def getBearerToken
    pattern = /^Bearer /
    request.authorization.gsub(pattern, '') if request.authorization
  end

  def decodeSignedJwtToken(token)
    JWT.decode(
      token,
      Rails.application.credentials.jwt_secret,
      true,
      { algorithm: 'HS256' }
    )
  end
end
