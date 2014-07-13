class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  # :recoverable, :rememberable and :trackable
  devise :database_authenticatable, :registerable, :validatable

  has_many :questions
  has_many :answers

  def save
  	if self.points >= 1000
  		self.badged = true
  	end
  	super
  end

  def to_s
    email
  end
end
