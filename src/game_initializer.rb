# require_relative 'valera'
# require_relative 'actions_handler'
# require_relative 'io_adapter'
# require_relative 'save_file'
# require_relative 'game'
# require 'inifile'

# class GameInitializer

#     def self.initialize_game
#         main_menu = File.new('./gamedata/main_menu.txt', 'r:UTF-8').read,
#         config = IniFile.load('./appdata/config.ini'),
#         valera = Valera.new(config['default']),
#         io_adapter = IoAdapter.new,
#         status = 'n',
#         game = ActionsHandler.new(config),
#         sv = SaveFile.new    

#         Game.new(main_menu, config,valera, io_adapter, status, game, sv)
#     end
# end
