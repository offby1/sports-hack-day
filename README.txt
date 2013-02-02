A quick hack to play with Twilio (http://www.twilio.com).

spam.rb sends a text message to every phone number that "we" know
about.  "We" are a Twilio account; we "know about" phone numbers by
dint of them having sent us a text message at some point.

To run this:

* First make sure you've got the necessary stuff installed: see
  https://www.twilio.com/docs/quickstart/ruby/devenvironment.

* Then run it like this:

        ./spam.rb "Here is some spam"
