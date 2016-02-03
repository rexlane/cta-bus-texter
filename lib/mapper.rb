class Mapper
  def get_location_coordinates(location)
    Geocoder.coordinates(location)
  end

  def get_formatted_address(query)
    Geocoder.search(query)[0].data['formatted_address']
  end

  def map(body)
    key = ENV['GOOGLE_STATIC_MAPS_KEY']
    base_url = 'https://maps.googleapis.com/maps/api/staticmap'
    image_params = 'zoom=16&size=400x400'
    formatted_address = get_formatted_address(body)
    coordinates = get_location_coordinates(body)
    coordinates = "#{coordinates[0]},#{coordinates[1]}"
    map_url = "#{base_url}?center=#{coordinates}&#{image_params}&key=#{key}"
    [formatted_address, map_url]
  end
end
