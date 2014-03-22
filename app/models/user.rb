class User < ActiveRecord::Base
  has_secure_password

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 } # verifying that name is present

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false }
    # uniqueness doesn't fully ensure uniqueness: i.e user hits submit button twice

  validates :password, presence: true, length: {minimum: 6}
  end
