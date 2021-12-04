require_relative '../src/save_file'
require_relative '../src/valera'
require 'inifile'

RSpec.describe SaveFile do
  describe 'Save and load file' do
    let(:config) { IniFile.load('appdata/config.ini') }
    let(:settings) { config['default'] }
    let(:valera_expected) { Valera.new(settings) }
    let(:valera) { Valera.new(settings) }
    let(:save_file) { SaveFile.new }

    it 'Save and load file' do
      save_file.save('1', valera_expected)
      valera = save_file.load('1')

      expect(valera.money).to eq(valera_expected.money)
      expect(valera.mana).to eq(valera_expected.mana)
      expect(valera.positive).to eq(valera_expected.positive)
      expect(valera.health).to eq(valera_expected.health)
      expect(valera.tiredness).to eq(valera_expected.tiredness)
    end

    it 'Load not created file' do
      valera = save_file.load('2')

      expect(valera).to eq nil
    end

    it 'Get saves list' do
      saves_list = save_file.saves_list

      expect(saves_list.length).to eq 1
      expect(saves_list[0]).to eq '1'
    end
  end
end
