class Sms < ActiveRecord::Base

	#attr_accessible :username, :password, :sender, :to, :body
	
	validates :username, :password, presence: true, length: { maximum: 30 }
	
	VALID_SENDER_REGEX = /([a-z]{8}|\d{4,12})/i
	validates :sender, presence: true, length: { maximum: 12 }, format: { with: VALID_SENDER_REGEX }
	
	VALID_TO_REGEX = /\d{4,12}/i
	validates :to, presence: true, length: { maximum: 12 }, format: { with: VALID_TO_REGEX }
		
	validates :body, presence: true, length: { maximum: 70 }	
	
end
