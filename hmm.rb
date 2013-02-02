require 'rubygems'
require 'twilio-ruby'

@account_sid = 'ACea596557c26be985fd44bd0a158e5094'
@auth_token = # your authtoken here

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(@account_sid, @auth_token)


@account = @client.account
@account.sms.messages.list({}).each do |@message|
  puts @message
end
