require_relative 'valera_action'
require_relative '../valera'

class ValeraBehold < Actions::ValeraActions::Based
  def go_behold
    set_health
    set_mana
    set_positive
    set_tiredness
    set_money
  end
end
