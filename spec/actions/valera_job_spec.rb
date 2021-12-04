require_relative '../../src/actions/valera_job'
require_relative '../../src/actions/valera_action'
require_relative '../../src/valera'
require 'inifile'

RSpec.describe Actions::ValeraActions do
  describe 'Go Job' do
    let(:config) { IniFile.load('appdata/config.ini') }
    let(:settings) { config['default'] }
    let(:valera) { Valera.new(settings) }

    it 'go job' do
      ValeraJob.new(config['job'], valera).go_job
      expect(valera.health).to eq(100)
      expect(valera.mana).to eq(0)
      expect(valera.positive).to eq(-5)
      expect(valera.tiredness).to eq(70)
      expect(valera.money).to eq(100)
    end

    it 'go job add conditions' do
      valera_def = Valera.new(settings)
      valera_def.set_stats(100, 40, 0, 5, 100)
      ValeraJob.new(config['job'], valera_def).go_job
      expect(valera_def.health).to eq(100)
      expect(valera_def.mana).to eq(10)
      expect(valera_def.positive).to eq(-5)
      expect(valera_def.tiredness).to eq(75)
      expect(valera_def.money).to eq(200)
    end

    it 'not go job' do
      valera_def = Valera.new(settings)
      valera_def.set_stats(100, 50, 0, 20, 100)
      ValeraJob.new(config['job'], valera_def).go_job
      expect(valera_def.health).to eq(100)
      expect(valera_def.mana).to eq(50)
      expect(valera_def.positive).to eq(0)
      expect(valera_def.tiredness).to eq(20)
      expect(valera_def.money).to eq(100)
    end
  end
end
