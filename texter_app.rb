require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/bus_stop'
require 'dotenv'
require 'geocoder'
require 'nokogiri'
require 'open-uri'
require_relative 'lib/mapper'
require_relative 'lib/twilier'
require_relative 'lib/parser'
require_relative 'lib/bus_tracker'
require_relative 'lib/cta_api_integration'

Dotenv.load

account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']

# account_sid = ENV['TEST_ACCOUNT_SID']
# auth_token = ENV['TEST_AUTH_TOKEN']

@client = Twilio::REST::Client.new account_sid, auth_token

$allowed_phone_numbers = ENV['ALLOWED_PHONE_NUMBERS'].split(',')


get '/' do
  if $allowed_phone_numbers.include? params[:From]
    r_method, r_arguments = Parser.new.parse_incoming_string(params[:Body])
    reply_text, reply_media = Parser.new.send(r_method, r_arguments)

    Twilier.new.put_reply(reply_text, reply_media)
    # Twilier.new.send_reply(reply_text, reply_media)
  else
    puts "Unauthorized number."
  end

end


