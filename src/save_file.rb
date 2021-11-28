require 'inifile'
require_relative 'src/valera.rb'

class SaveFile
  def load(slot)
    ini = IniFile.load("appdata/save_#{slot}.ini")
    Valera.new(ini['default']) if !ini.nil? && !ini['default'].nil?
  end

  def save(slot, valera)
    ini = IniFile.load("appdata/save_#{slot}.ini")
    ini = create_file(slot) if ini.nil?
    ini = update_ini(valera, ini)
    write(ini)
  end

  def saves_list_get
    saves_list = Dir['./appdata/save_*.ini']
    (0..saves_list.length - 1).each do |i|
      saves_list[i] = saves_list[i][15..saves_list[i].length - 5]
    end
    saves_list
  end

  private

  def create_file(slot)
    f = File.open("appdata/save_#{slot}.ini", 'w')
    f.close
    IniFile.load("appdata/save_#{slot}.ini")
  end

  def update_ini(valera, ini)
    ini['default']['health'] = valera.health
    ini['default']['mana'] = valera.mana
    ini['default']['positive'] = valera.positive
    ini['default']['tiredness'] = valera.tiredness
    ini['default']['money'] = valera.money
    ini
  end

  def write(ini)
    ini.write
  end
end
