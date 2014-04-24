class User < ActiveRecord::Base
  #attr_accessible :name, :email, :password, :password_confirmation

  # "dependent: :destroy" arranges for the dependent microposts (i.e., the ones belonging to the given user) 
  # to be destroyed when the user itself is destroyed. This prevents userless microposts 
  # from being stranded in the database when admins choose to remove users from the system.
  has_many :courses, dependent: :destroy
  has_secure_password

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 } # verifying that name is present

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@colorado.edu/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false }
    # uniqueness doesn't fully ensure uniqueness: i.e user hits submit button twice

  validates :password, presence: true, length: {minimum: 6}

  serialize :courses_taken

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end



  private

  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end
end
