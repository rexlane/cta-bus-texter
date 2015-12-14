require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'dotenv'
require 'geocoder'

Dotenv.load

account_sid = ENV['ACCOUNT_SID']
auth_token = ENV['AUTH_TOKEN']

# account_sid = ENV['TEST_ACCOUNT_SID']
# auth_token = ENV['TEST_AUTH_TOKEN']

@client = Twilio::REST::Client.new account_sid, auth_token

$allowed_phone_numbers = ENV['ALLOWED_PHONE_NUMBERS'].split(',')

$existing_methods = ["map"]

get '/' do

  if $allowed_phone_numbers.include? params[:From]
    incoming_body = params[:Body].split(" ", 2)

    if incoming_body[0] && incoming_body[1]
      method_name = permitted_method(incoming_body[0].downcase)
    else
      method_name = "no_matching_method"
    end

    send(method_name, incoming_body[1]) 
      
  else
    puts "Unauthorized number."
  end

end

def send_reply(reply_body_string, reply_media_url = nil)
  twiml = Twilio::TwiML::Response.new do |response|
    response.Message do |message| 
      
      message.Body reply_body_string
      
      if reply_media_url
        message.Media reply_media_url
      end

    end
  end
  twiml.text
end

def permitted_method(requested_method)
  if $existing_methods.include? requested_method
    return requested_method
  else
    "no_matching_method"
  end
end

def no_matching_method(body=nil)
  error_string = "Sorry, I don't understand. Try texting \"map [place]\"."
  send_reply(error_string)
end

def get_location_coordinates(query)
  location = Geocoder.search(query)[0].data["geometry"]["location"]
  latitude = (location["lat"] * 1000000).to_i / 1000000.0
  longitude = (location["lng"] * 1000000).to_i / 1000000.0
  coordinates_array = [latitude, longitude]
end

def get_formatted_address(query)
  formatted_address = Geocoder.search(query)[0].data["formatted_address"]
end

def map(body)
  formatted_address = get_formatted_address(body)
  coordinate_array = get_location_coordinates(body)
  coordinate_string = "#{coordinate_array[0].to_s},#{coordinate_array[1].to_s}"
  map_url = "https://maps.googleapis.com/maps/api/staticmap?center=#{coordinate_string}&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}"
  
  send_reply(formatted_address, map_url)

end

