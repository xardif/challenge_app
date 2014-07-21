class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  def has_title?
  	self.title.present?
  end
end
