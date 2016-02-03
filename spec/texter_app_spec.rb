require 'spec_helper'

describe 'texter_app' do
  # it 'calls the right things' do
  # end

  it 'calls the right things' do
    parser = Parser.new
    method = 'map'
    arguments = 'western and milwaukee chicago'
    target_address = 'N Milwaukee Ave & N Western Ave, Chicago, IL 60647, USA'
    key = ENV['GOOGLE_STATIC_MAPS_KEY']
    base_url = 'https://maps.googleapis.com/maps/api/staticmap'
    coordinate_target = '41.916779,-87.68732290000001'
    image_params = 'zoom=16&size=400x400'
    target_url = "#{base_url}?center=#{coordinate_target}&#{image_params}&key=#{key}"
    expect(parser.send(method, arguments)).to eq([target_address, target_url])
  end

  describe 'sorry' do
    it 'says sorry' do
      parser = Parser.new
      help_msg = 'Try one of these: BUS [location] [direction]; MAP [location]; DEFINE [word]'
      expect(parser.helpme).to eq([help_msg, nil])
    end
  end

  describe 'no_matching_method' do
    it 'responds to bad method' do
      parser = Parser.new.no_matching_method
      help_msg_start = "Sorry, I don't understand. Try one of these: BUS [location]"
      expect(parser[0].start_with?(help_msg_start)).to eq(true)
      expect(parser[1]).to eq(nil)
    end
  end
end
