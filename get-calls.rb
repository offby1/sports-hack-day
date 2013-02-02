#!/usr/bin/env ruby

require 'rubygems'
require 'twilio-ruby'
require 'twilio-creds'

@account_sid = ENV['TWILIO_ACCOUNT_SID']
@auth_token =  ENV['TWILIO_AUTH_TOKEN']

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(@account_sid, @auth_token)


@account = @client.account
@account.sms.messages.list({}).each do |@message|
  [:from, :to, :body].each do |att|
    puts "#{att}: #{@message.send(att)}"
  end
end
