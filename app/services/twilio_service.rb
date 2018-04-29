require 'twilio-ruby'
class TwilioService
  AccountSid = 'AC4b35fda44c0492996a609f2e8c8c22c4'
  AuthToken = '95aa5484149e68cddbfbf468a1627a08'

  def initialize
    @client ||= Twilio::REST::Client.new(AccountSid, AuthToken)
  end

  def send_message_to(taker, giver)
    message = @client.messages.create(
        body: "#{giver.description} at #{giver.address} is available for you.",
        to: taker.phone_number,
        from: '+13475945626',
    )
    p message.sid
  end
end