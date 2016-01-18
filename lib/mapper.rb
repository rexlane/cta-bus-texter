class Mapper

  def get_location_coordinates(location)
    Geocoder.coordinates(location)
  end

  def get_formatted_address(query)
    formatted_address = Geocoder.search(query)[0].data["formatted_address"]
  end

  def map(body)
    base_url = "https://maps.googleapis.com/maps/api/staticmap"
    formatted_address = get_formatted_address(body)
    coordinates = get_location_coordinates(body)
    coordinate_string = "#{coordinates[0].to_s},#{coordinates[1].to_s}"
    map_url = "#{base_url}?center=#{coordinate_string}&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}"
    
    return formatted_address, map_url
  
  end

  # move out of Mapper
  def define(word)
    dictionary_url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{word}?key=#{ENV["DICTIONARY_KEY"]}"
    doc = Nokogiri::HTML(open(dictionary_url))
    definition = doc.xpath("//def//dt").first.content
  end

end
