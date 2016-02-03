class Twilier
  def put_reply(reply_text, reply_media)
    puts reply_text
    puts reply_media if reply_media
  end

  def send_reply(reply_text, reply_media)
    twiml = Twilio::TwiML::Response.new do |response|
      response.Message do |message|
        message.Body reply_text
        message.Media reply_media if reply_media
      end
    end
    twiml.text
  end
end
