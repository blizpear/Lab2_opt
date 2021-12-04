require_relative '../../src/actions/valera_drink'
require_relative '../../src/actions/valera_action'
require_relative '../../src/valera'
require 'inifile'

RSpec.describe Actions::ValeraActions do
  describe 'Go Drink' do
    let(:config) { IniFile.load('appdata/config.ini') }
    let(:settings) { config['default'] }
    let(:valera) { Valera.new(settings) }

    it 'go drink' do
      ValeraDrink.new(config['drink'], valera).go_drink
      expect(valera.health).to eq(20)
      expect(valera.mana).to eq(90)
      expect(valera.positive).to eq(5)
      expect(valera.tiredness).to eq(80)
      expect(valera.money).to eq(-150)
    end
  end
end
