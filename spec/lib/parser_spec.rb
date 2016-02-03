require 'spec_helper'

describe Parser do
  describe 'parse_method_name' do
    it 'returns a method name' do
      split_string = ['bus', 'milwaukee and chicago north']
      expect(Parser.new.parse_method_name(split_string)).to eq('bus')
    end
  end

  describe 'parse_arguments' do
    it 'returns arguments' do
      split_string = ['bus', 'milwaukee and chicago north']
      expect(Parser.new.parse_arguments(split_string)).to eq('milwaukee and chicago north')
    end
  end

  describe 'permitted method checker' do
    it 'returns the method name of a permitted method' do
      target = 'map'
      expect(Parser.new.permitted_method('map')).to eq(target)
    end

    it 'returns an error in response to a nonexistant method' do
      target = 'no_matching_method'
      incoming_method_string = 'do_bad_stuff'
      expect(Parser.new.permitted_method(incoming_method_string)).to eq(target)
    end

    it 'calls an error if map has no parameters' do
      target = [HelpMessage.new.no_matching_method, nil]
      expect(Parser.new.map(nil)).to eq(target)
    end
  end
end
