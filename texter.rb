class Texter

  def no_matching_method(body=nil)
    error_string = "Sorry, I don't understand. Try texting \"map [place]\"."
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
    base_url = "https://maps.googleapis.com/maps/api/staticmap"
    formatted_address = get_formatted_address(body)
    coordinate_array = get_location_coordinates(body)
    coordinate_string = "#{coordinate_array[0].to_s},#{coordinate_array[1].to_s}"
    map_url = "#{base_url}?center=#{coordinate_string}&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}"

    return formatted_address, map_url
  end

  def define(word)
    dictionary_url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{word}?key=#{ENV["DICTIONARY_KEY"]}"
    doc = Nokogiri::HTML(open(dictionary_url))
    definition = doc.xpath("//def//dt").first.content
  end

end
