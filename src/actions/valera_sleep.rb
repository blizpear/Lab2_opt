require_relative 'valera_action'
require_relative '../valera'

class ValeraSleep < Actions::ValeraActions::Based
  def go_sleep
    @valera.health += @stats['health'] if @valera.mana < @stats['health_mana_max']
    @valera.positive += @stats['positive'] if @valera.mana > @stats['positive_mana_min']
    @valera.health = @valera.health >= 100 ? 100 : @valera.health

    set_mana
    set_tiredness
    set_money
  end
end
