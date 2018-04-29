require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'


class TakerListener
  def free_food (giver)
    twilio_service = TwilioService.new
    taker = Taker.all.sample
    twilio_service.send_message_to(taker, giver)
    ls = LambdaService.new
    ls.send_lumnes
  end
end