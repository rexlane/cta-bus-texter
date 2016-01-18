class Twilier

  def put_reply(reply_text, reply_media)
    puts reply_text
    if reply_media
      puts reply_media
    else
      puts "no image"
    end
  end

  def send_reply(reply_text, reply_media)
    twiml = Twilio::TwiML::Response.new do |response|
      response.Message do |message| 
        message.Body reply_text
        
        if reply_media
          message.Media reply_media
        end

      end
    end
    twiml.text
  end

end