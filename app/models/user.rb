class User < ApplicationRecord
  has_secure_password

  def to_token_payload
    {
      sub: id,
      admin: true,
      email: email
    }
  end

  def valid_password? input_password
    password == input_password
  end

  private

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_digest = @password
  end
end
