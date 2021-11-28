class IoAdapter
  def initialize
    @messages = IniFile.load('./gamedata/game_statuses.ini')['default']
  end

  def new_line
    puts
  end

  def writeln(message)
    puts message
  end

  def write(message)
    print message
  end

  def clear
    system('clear')
  end

  def read_line
    gets
  end

  def input_choice
    loop do
      print ' > '
      inpt = gets.chomp.downcase
      return inpt if (inpt.to_i >= 1 && inpt.to_i <= 7) || inpt == 'n' || inpt == 's' || inpt == 'l' || inpt == 'q'

      output_status('er')
    end
  end

  def output_status(status)
    puts @messages[status]
  end
end
