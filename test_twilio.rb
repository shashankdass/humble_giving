require 'twilio-ruby'

account_sid = "AC4b35fda44c0492996a609f2e8c8c22c4" # Your Account SID from www.twilio.com/console
auth_token = "95aa5484149e68cddbfbf468a1627a08"   # Your Auth Token from www.twilio.com/console

@client = Twilio::REST::Client.new account_sid, auth_token
message = @client.messages.create(
    body: "Hello from Ruby",
    to: "+16318893142",    # Replace with your phone number
    from: "+13475945626")  # Replace with your Twilio number

puts message.sid
