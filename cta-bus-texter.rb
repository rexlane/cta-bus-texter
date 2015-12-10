require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'dotenv'
require 'geocoder'

Dotenv.load

account_sid = ENV['ACCOUNT_SID']
auth_token = ENV['AUTH_TOKEN']
client = Twilio::REST::Client.new account_sid, auth_token


@body = params[:Body]


get '/' do
#   'Sinatra is running on Heroku. Currently running version ' + Twilio::VERSION + \
#         ' of the twilio-ruby library.'
# end

# get '/sms-quickstart' do
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message do |message| 
      message.Body "The thing you said was #{@body}"
      # message.Media "https://demo.twilio.com/owl.png"
    end
  end
  twiml.text
end