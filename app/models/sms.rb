class Sms
	attr_accessor :username, :password, :sender, :to, :body
	
	def initialize(params = nil)
		if params
			@username = params['username']
			@password = params['password']
			@sender = params['sender']
			@to = params['to']
			@body = params['body']
		end
	end
end