class ApiController < ApplicationController
  # Authenticity token is a token to validate a form submission for SSR.
  # Since it's an API, it's redundant and would double every request to get this token.
  skip_before_action :verify_authenticity_token

  # attr_reader current_user
  before_action :set_default_format
  before_action :authenticate_token!

  private

  def set_default_format
    request.format = :json
  end

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)

    # if payload.present?
    #   @current_user = User.find(payload["sub"])

    #   p @current_user
    # else
    #   render json: { errors: ["Invalid auth token"]}, status: :unauthorized
    # end

    @current_user = User.find(payload["sub"])
      p @current_user

  rescue JWT::ExpiredSignature
    render json: { errors: ["Auth token has expired"]}, status: :unauthorized
  rescue JWT::DecodeError
    render json: { errors: ["Invalid auth token"]}, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers.fetch("Authorization", "").split(" ").last
  end
end