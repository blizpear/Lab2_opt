require 'rspec'
require_relative '../src/game'
require_relative '../src/io_adapter'
require_relative '../src/game_states'

describe Game do
  include GameStates

  let(:Menu) { Menu.new }
  let(:FileManager) { FileManager.new }
  let(:IoAdapter) { IoAdapter.new }

  before do
    allow(Menu).to receive(:render_game_menu)
    allow(Menu).to receive(:print_saved)
    allow(Menu).to receive(:print_game_over)

    allow(FileManager).to receive(:save)
    allow(FileManager).to receive(:load_config).and_return(
      Hash.new({ actions: [
                 {
                   name: 'Go to work',
                   conditions: [
                     {
                       name: 'alcohol',
                       min: 0,
                       max: 70
                     },
                     {
                       name: 'tiredness',
                       min: 0,
                       max: 10
                     }
                   ],
                   result: [
                     {
                       name: 'alcohol',
                       value: -30
                     },
                     {
                       name: 'positive',
                       value: -5
                     },
                     {
                       name: 'tiredness',
                       value: 70
                     },
                     {
                       name: 'money',
                       value: 100
                     }
                   ]
                 }
               ] })
    )
  end

  describe 'Game test' do
    it 'Exit works' do
      allow(IoAdapter).to receive(:pressed_key).and_return('q')

      game = Game.new(Menu, FileManager, IoAdapter)
      state, = game.iterate_game(FileManager.load_config, Valera.new, nil)
      expect(state).to eq 2
    end

    it 'save works' do
      allow(IoAdapter).to receive(:pressed_key).and_return('s')

      game = Game.new(Menu, FileManager, IoAdapter)
      state, = game.iterate_game(FileManager.load_config, Valera.new, nil)
      expect(state).to eq 1
    end

    it 'menu works' do
      allow(IoAdapter).to receive(:pressed_key).and_return('m')

      game = Game.new(Menu, FileManager, IoAdapter)
      state, = game.iterate_game(FileManager.load_config, Valera.new, nil)
      expect(state).to eq 0
    end
  end
end
