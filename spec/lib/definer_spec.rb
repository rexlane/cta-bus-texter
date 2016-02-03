require 'spec_helper'

describe Definer do
  describe 'define method' do
    it 'returns a definition' do
      target_start = 'tortilla: :a thin round of unleavened cornmeal'
      tortilla_definition = Definer.new.define('tortilla')
      expect(tortilla_definition.start_with?(target_start)).to eq(true)
    end
  end
end
