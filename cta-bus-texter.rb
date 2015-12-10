require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'dotenv'
require 'geocoder'

Dotenv.load

account_sid = ENV['ACCOUNT_SID']
auth_token = ENV['AUTH_TOKEN']

@client = Twilio::REST::Client.new account_sid, auth_token

# @client.messages.list.each do |message|
#   puts message.direction
#   puts message.body
# end


# @message = @client.messages.create(
#   to: ENV['MY_NUM'],
#   from: ENV['TWILIO_NUM'],
#   body: "This is a test."
#   media_url: "http://twilio.com/heart.jpg"
# )

get '/' do
  @incoming_body = params[:Body]

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message do |message| 
      message.Body "The thing you said was #{@incoming_body}"
      # message.Media "https://demo.twilio.com/owl.png"
    end
  end
  twiml.text
end