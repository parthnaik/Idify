class User < ActiveRecord::Base
	has_many :ideas
	has_many :votes, foreign_key: :voter_id
  has_many :voted_ideas, through: :votes, source: :idea
	has_many :images, through: :ideas
	
  validates :email, :format => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  include BCrypt
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @entered_password = pass
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil # either invalid email or wrong password
  end
end
