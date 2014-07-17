class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  # :recoverable, :rememberable and :trackable
  devise :database_authenticatable, :registerable, :validatable, :authentication_keys => [:login]
  attr_accessor :login

  has_many :questions
  has_many :answers

  has_attached_file :avatar, styles: {
    thumb: '100x100>'
  }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }, format: { with: /\A[a-zA-Z0-9_]+\Z/ }

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def save
  	if self.points >= 1000
  		self.badged = true
  	end
  	super
  end

  def to_s
    username
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
end
