require 'spec_helper'

describe HelpMessage do
  describe 'sorry' do
    it 'says sorry' do
      response = 'Try one of these: BUS [location] [direction]; MAP [location]; DEFINE [word]'
      expect(HelpMessage.new.all_help).to eq(response)
    end
  end

  describe 'no_matching_method' do
    it 'responds to bad method' do
      response_1 = "Sorry, I don't understand. Try one of these:"
      response_2 = 'BUS [location] [direction]; MAP [location]; DEFINE [word]'
      expect(HelpMessage.new.no_matching_method).to eq("#{response_1} #{response_2}")
    end
  end
end
