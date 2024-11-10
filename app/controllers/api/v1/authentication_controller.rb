class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_token!

  def create
    # binding.break
    user = User.find_by(email: params[:user][:email])
    # @FIX_ME: valid_password is not working - check devise documentation to fix this and go to 21min of the video (3)
    if user.valid_password? params[:user][:password]
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ["Invalid email or password"]}
    end
  end
end