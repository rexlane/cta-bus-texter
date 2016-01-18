Search for CTA bus arrival times with a simple text; no stop id required. Request maps as static image files. For getting places without compromising your lo-fi dumbphone aesthetic.

## Setting it Up

This is a Sinatra app. It uses the `twilio-ruby` gem to handle sending and receiving texts. You'll need your own [Twilio](https://www.twilio.com/) account and text-enabled phone number. (Trial accounts are free but have some restrictions.)

I have an `.env` file that looks like this (all values from Twilio, [Google](https://console.developers.google.com), the [CTA](http://www.transitchicago.com/developers/), etc.):

```
TWILIO_ACCOUNT_SID  
TWILIO_AUTH_TOKEN  
TWILIO_NUM  
ALLOWED_PHONE_NUMBERS  
CTABUS_KEY  
GOOGLE_STATIC_MAPS_KEY  
GOOGLE_STATIC_MAPS_SECRET  
DICTIONARY_KEY  
```

This app uses Postgres and ActiveRecord to manage bus stop details. Geocoding by the `geocoder` gem.

## Options

This app understands the following requests:

- **HelpMe**
<br />Returns a list of available options. ("Help" alone calls up Twilio's help menu, not ours.)
- **Map \[location\]**
<br />Returns a map of that location as a static image file. The location can be an address, intersection, zip code, etc. Defaults to Chicago.
- **Bus \[location\] \[direction\]**
<br />Returns arrival times for the nearest bus stop.
- **Define \[word\]**
<br />For reading on the bus.

## Running it Locally

To test the app locally:

1. Start the server by running `rackup` in the terminal. Get the port number (something like 9292).
2. Point nrgok toward that port: `ngrok 9292`.
3. Grab the ngrok url (something like https://123a4bcd.ngrok.com) from your terminal. 
4. Go to the phone number configuration page of your Twilio account. Under "Messaging," add your ngrok url to the "Request URL" box.

When you're ready to push the app to Heroku or wherever, be sure to replace the ngrok url with the hosted one.