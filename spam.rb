#!/usr/bin/env ruby

# Command-line tool to send a short message to everyone who has ever
# texted our Twilio number.  See
# https://www.twilio.com/user/account/log/sms e.g., assuming of course
# that you have a Twilio account :)

require 'rubygems'
require 'twilio-ruby'

begin
  require 'twilio-creds'          # a local file in this directory.
rescue LoadError => e
  puts "#{e} -- you need account credentials.  See the README."
  exit(1)
end

require 'pp'
require 'set'

@account_sid = ENV['TWILIO_ACCOUNT_SID']
@auth_token  = ENV['TWILIO_AUTH_TOKEN']

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(@account_sid, @auth_token)

# Ask twilio for all the numbers we know about.  A real app would keep
# this information locally.
def known_numbers
  numbers = {}

  numbers[:me] = Set.new(@client.account.incoming_phone_numbers.list.map(&:phone_number))

  @client.account.sms.messages.list({}).each do |@message|
    if @message.direction == "inbound"
      numbers[:victims] ||= Set.new
      numbers[:victims] << @message.from
    end
  end
  return numbers
end

def spam_everyone(message)

  # Choose an outgoing number at random, as a form of crude
  # load-balancing.  Since outgoing messages are throttled per
  # outgoing number, the more outgoing numbers I purchase, the faster
  # I can send outgoing messages.
  originating_number = known_numbers[:me].to_a.choice

  known_numbers[:victims].each do |victim|
    params = {
      :from => originating_number,
      :to   => victim,
      :body => message
    }
    print "Sending #{params.inspect} ... "
    puts @client.account.sms.messages.create(params)
  end
end

if ARGV
  spam_everyone(ARGV[0])
end
