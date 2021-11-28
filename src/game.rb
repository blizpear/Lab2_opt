require 'inifile'
require_relative 'valera'
require_relative 'actions_handler'
require_relative 'io_adapter'
require_relative 'save_file'

class Game
  def initialize
    @main_menu = File.new('./gamedata/main_menu.txt', 'r:UTF-8').read
    @config = IniFile.load('./appdata/config.ini')
    @valera = Valera.new(@config['default'])
    @io_adapter = IoAdapter.new
    @status = 'n'
    @game = ActionsHandler.new(@valera, @config)
    @sv = SaveFile.new
  end

  def print_existing_saves
    saves_list = @sv.saves_list

    if saves_list.length.zero?
      @io_adapter.output_status 'sv_no'
      @io_adapter.new_line
      return
    end

    @io_adapter.output_status 'exs_sv'
    saves_list.each do |i|
      @io_adapter.writeln "[#{i}]\n"
    end
    @io_adapter.new_line
  end

  def menu_new
    @valera = Valera.new(@config['default'])
    @game.valera_set(@valera)
  end

  def menu_save
    @io_adapter.clear
    @io_adapter.writeln @main_menu

    print_existing_saves
    @io_adapter.output_status 'slt_sv'

    @io_adapter.write ' > '
    save_id = @io_adapter.read_line
    @sv.save(save_id[0, save_id.length - 1], @valera)
  end

  def menu_load
    @io_adapter.clear
    @io_adapter.writeln @main_menu

    print_existing_saves
    @io_adapter.output_status 'ld_sv'

    print ' > '
    save_id = $stdin.gets
    valera_new = @sv.load(save_id[0, save_id.length - 1])

    if valera_new.nil?
      @status = 'nl'
    else
      @valera = valera_new
      @game.valera_set(valera_new)
    end
  end

  def menu_chosen
    case @status
    when 'n'
      menu_new
    when 's'
      menu_save
    when 'l'
      menu_load
    when 'q'
      exit
    end
  end

  def main_game_loop
    while game_continues?
      print_game
      @status = @io_adapter.input_choice
      @game.game_loop(@status)
      menu_chosen
    end
  end

  def game_continues?
    @valera.health.positive? && @valera.mana <= 100 && @valera.money >= 0
  end

  def print_game
    @io_adapter.clear
    @io_adapter.writeln @main_menu
    @io_adapter.output_status @status
    @io_adapter.writeln 'stats'
    @io_adapter.writeln "[HP]           #{@valera.health}"
    @io_adapter.writeln "[MANA]         #{@valera.mana}"
    @io_adapter.writeln "[POSITIVE]     #{@valera.positive}"
    @io_adapter.writeln "[TIREDNESS]    #{@valera.tiredness}"
    @io_adapter.writeln "[MONEY]        #{@valera.money}"
  end

  def start
    main_game_loop
    if @valera.health <= 0
      @status = 'dh'
    elsif @valera.mana > 100
      @status = 'da'
    elsif @valera.money.negative?
      @status = 'dm'
    end
    print_game
  end
end
