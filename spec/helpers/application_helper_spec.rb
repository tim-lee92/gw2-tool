require 'rails_helper'

describe ApplicationHelper do
  describe '#convert_to_coins' do
    it 'returns a hash' do
      expect(convert_to_coins(254522)).to be_instance_of(Hash)
    end

    it 'returns the right amount of gold/silver/copper' do
      expect(convert_to_coins(254522)[:gold]).to eq(25)
      expect(convert_to_coins(254522)[:silver]).to eq(45)
      expect(convert_to_coins(254522)[:copper]).to eq(22)
    end
  end

  describe '#format_coins' do
    it 'returns a string' do
      expect(format_coins(254522)).to be_instance_of(String)
    end
  end
end
