class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  def empty?
    contents.empty?
  end

  def accept!
  	self.question.accepted_answer_id = id
	self.question.save

	self.user.add_points!(25)
  end

  def liked_by?(user)
  	self.liked_by.include? user.id
  end

  def like!(user)
  	if liked_by?(user)
  		self.liked_by.delete(user.id)
		self.user.add_points!(-5)
  	else
  		self.liked_by.append(user.id)
		self.user.add_points!(5)
	end
	self.liked_by_will_change!
	self.save
	liked_by?(user)
  end

end
