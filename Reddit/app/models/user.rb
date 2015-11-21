# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password
  validates(
        :email,
        :username,
        :password_digest,
        :session_token,
        presence: true
  )
  validates :username, :session_token, uniqueness: true

  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :subs, foreign_key: :moderator_id

  has_many :posts, foreign_key: :author_id

  after_initialize :ensure_session_token!


  def reset_session_token!
    self.session_token = generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token!
    self.session_token ||= generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    self.save
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return user if user && user.is_password?(password)
  end

  private
  def generate_session_token
    SecureRandom.urlsafe_base64
  end

end
