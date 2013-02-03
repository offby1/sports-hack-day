A quick hack to play with Twilio (http://www.twilio.com).

spam.rb sends a text message to every phone number that "we" know
about.  "We" are a Twilio account; we "know about" phone numbers by
dint of them having sent us a text message at some point.

To run this:

* First make sure you've got the necessary stuff installed: see
  https://www.twilio.com/docs/quickstart/ruby/devenvironment.

* Get ye a twilio account.  They're cheap; mine cost $20.

* Edit twilio-creds.rb.template according to the instructions.

* Have a few people (perhaps including yourself) send a text (whose
  content doesn't matter) to your new twilio SMS number.

* Run it like this:

        ./spam.rb "Here is some spam"

The text message "Here is some spam" will get sent to everyone who texted you.
