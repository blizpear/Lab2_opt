require_relative '../src/valera'
require_relative '../src/actions/valera_action'
require 'inifile'

RSpec.describe Valera do
  describe 'Valera Default' do
    let(:config) { IniFile.load('appdata/config.ini') }
    let(:settings) { config['default'] }
    let(:valera) { Valera.new(settings) }

    it 'start config' do
      expect(valera.health).to eq(100)
      expect(valera.mana).to eq(0)
      expect(valera.positive).to eq(0)
      expect(valera.tiredness).to eq(0)
      expect(valera.money).to eq(0)
    end
  end
end
