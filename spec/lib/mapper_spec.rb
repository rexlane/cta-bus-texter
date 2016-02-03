require 'spec_helper'

describe Mapper do
  describe 'get_location_coordinates' do
    it 'returns array of latitude and longitude' do
      expect(Mapper.new.get_location_coordinates('chicago')).to eq([41.8781136, -87.6297982])
    end
  end

  describe 'get_formatted_address' do
    it 'returns formatted address' do
      expect(Mapper.new.get_formatted_address('chicago')).to eq('Chicago, IL, USA')
    end
  end

  describe 'map method' do
    it 'returns a static map url based on city name' do
      body = 'chicago'
      base_url = 'https://maps.googleapis.com/maps/api/staticmap'
      image_params = 'zoom=16&size=400x400'
      key = ENV['GOOGLE_STATIC_MAPS_KEY']
      address_target = 'Chicago, IL, USA'
      coordinate_target = '41.8781136,-87.6297982'
      target_url = "#{base_url}?center=#{coordinate_target}&#{image_params}&key=#{key}"
      expect(Mapper.new.map(body)).to eq([address_target, target_url])
    end

    it 'returns a static map url based on intersection' do
      body = 'western and milwaukee chicago'
      base_url = 'https://maps.googleapis.com/maps/api/staticmap'
      image_params = 'zoom=16&size=400x400'
      key = ENV['GOOGLE_STATIC_MAPS_KEY']
      address_target = 'N Milwaukee Ave & N Western Ave, Chicago, IL 60647, USA'
      coordinate_target = '41.916779,-87.68732290000001'
      target_url = "#{base_url}?center=#{coordinate_target}&#{image_params}&key=#{key}"
      expect(Mapper.new.map(body)).to eq([address_target, target_url])
    end
  end
end
