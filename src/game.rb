require_relative './game_states'
require_relative './actions'

class Game
  include GameStates

  def initialize(menu, file_manager, input)
    @menu = menu
    @file_manager = file_manager
    @input = input
  end

  def start
    game
  end

  def game
    config = @file_manager.load_config
    state = RENDER_MENU
    valera = Valera.new
    error = nil

    loop do
      case state
      when RENDER_MENU
        state, valera = main_menu
      when GAME
        state, valera, error = iterate_game(config, valera, error)
      when EXIT_GAME
        return
      end
    end
  end

  def main_menu
    @menu.print_main_menu

    input = @input.pressed_key.to_i

    case input
    when 1
      [GAME, Valera.new]
    when 2
      saved_game = @file_manager.load_game
      [GAME, Valera.new(saved_game)]
    when 3
      EXIT_GAME
    else
      RENDER_MENU
    end
  end

  def iterate_game(config, valera, error)
    @menu.render_game_menu(valera, error)
    input = @input.pressed_key

    case input
    when 'q'
      return EXIT_GAME
    when 'm'
      @file_manager.save(valera)
      return RENDER_MENU, valera
    when 's'
      @file_manager.save(valera)
      @menu.print_saved
      @input.pressed_key
    end

    input = input.to_i - 1
    return GAME, valera if input.negative? || input > config['actions'].length - 1

    error = Actions.new.do_action(config['actions'][input], valera)

    if valera.dead?
      @menu.print_game_over
      @input.pressed_key
      return RENDER_MENU, valera
    end
    [GAME, valera, error]
  end
end
