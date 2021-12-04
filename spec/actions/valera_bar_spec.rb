require_relative '../../src/actions/valera_bar'
require_relative '../../src/actions/valera_action'
require_relative '../../src/valera'
require 'inifile'

RSpec.describe Actions::ValeraActions do
  describe 'Go Bar' do
    let(:config) { IniFile.load('appdata/config.ini') }
    let(:settings) { config['default'] }
    let(:valera) { Valera.new(settings) }

    it 'go bar' do
      ValeraBar.new(config['bar'], valera).go_bar
      expect(valera.health).to eq(90)
      expect(valera.mana).to eq(60)
      expect(valera.positive).to eq(1)
      expect(valera.tiredness).to eq(40)
      expect(valera.money).to eq(-100)
    end
  end
end
