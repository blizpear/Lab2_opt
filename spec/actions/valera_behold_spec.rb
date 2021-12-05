require_relative '../../src/actions/valera_behold'
require_relative '../../src/actions/valera_action'
require_relative '../../src/valera'
require 'inifile'

RSpec.describe Actions::ValeraActions do
  describe 'Go Behold' do
    let(:config) { IniFile.load('appdata/config.ini') }
    let(:settings) { config['default'] }
    let(:valera) { Valera.new(settings) }

    it 'go behold' do
      ValeraBehold.new(config['behold'], valera).go_behold
      expect(valera.health).to eq(100)
      expect(valera.mana).to eq(0)
      expect(valera.positive).to eq(1)
      expect(valera.tiredness).to eq(10)
      expect(valera.money).to eq(0)
    end
  end
end
