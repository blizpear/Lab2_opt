require_relative 'valera_action'
require_relative '../valera'

class ValeraJob < Actions::ValeraActions::Based
  def go_job
    if (@valera.mana >= @stats['req_mana_max']) && (@valera.tiredness >= @stats['req_tiredness_max'])
      puts 'Action is impossible. You are too drunk!'
      return
    end

    set_health
    set_mana
    set_positive
    set_tiredness
    set_money
  end
end
