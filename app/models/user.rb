class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { in: 6..10 }

  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase); 
    if user && user.authenticate(password)
      return user
    else 
      return nil
    end
  end

end