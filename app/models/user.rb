class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true

  has_many :donations
  has_many :posts
  has_many :comments

  def generate_token
    self.update_column(:token, SecureRandom.urlsafe_base64)
  end
end
