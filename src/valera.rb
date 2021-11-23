class Valera
  attr_accessor :health, :mana, :positive, :tiredness, :money
  
  def initialize(setting)
    @health = setting['health']
    @mana = setting['mana']
    @positive = setting['positive']
    @tiredness = setting['tiredness']
    @money = setting['money']
  end
  
  def set_stats(health, mana, positive, tiredness, money)
    @health = health
    @mana = mana
    @positive = positive
    @tiredness = tiredness
    @money = money
  end
end
