require_relative 'valera_action'
require_relative '../valera'

class ValeraSing < Actions::ValeraActions::Based
  def go_sing
    bonus_money
    set_health
    set_mana
    set_positive
    set_tiredness
    set_money
  end

  def bonus(first_condition, second_condition)
    return unless first_condition && second_condition

    @valera.money += @stats['money_bonus']
    puts 'Bonus accrued'
    gets.chomp
  end

  def bonus_money
    first_condition = @valera.mana > @stats['money_bonus_mana_min']
    second_condition = @valera.mana < @stats['money_bonus_mana_max']

    bonus(first_condition, second_condition)
  end
end
