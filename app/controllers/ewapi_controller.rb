require 'savon'

class EwapiController < ApplicationController
  
  def index
	@sms = Sms.new
  end
  
  def create
	sms = Sms.new(sms_params)
	
	client = Savon.client(:wsdl => 'http://si.rapidsms.net/api/mysms.asmx?wsdl')
	logger.debug "Savon client - #{client}"
	
	#operations = client.operations
	#logger.debug operations

	@response = call_and_fail_gracefully(client, :send_sms2, :message => { 'userName' => sms.username, 'password' => sms.password, 'toMobile' => sms.to, 'recipientName' => sms.to, 'senderID' => sms.sender, 'smsText' => sms.body, 'SMSType' => '', 'Apptype' => '', 'taskName' => '', 'timeOffset' => 0, 'priority' => 3 })
	logger.debug "Response - #{@response}"
  end
  
  private
	  def sms_params 
		params.require(:sms).permit(:username, :password, :sender, :to, :body)
	  end
	  
	  def call_and_fail_gracefully(client, *args, &block)
		response = client.call(*args, &block)
		return response.to_s.gsub! "><", ">\r\n<"
	  rescue Savon::SOAPFault => e
		stacktrace = e.backtrace.join("\r\n")
		msg = "#{e.message}\r\nStackTrace:\r\n#{stacktrace}"
		logger.debug msg
		return msg
	  end
end
