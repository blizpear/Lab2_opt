require_relative '../valera'

module Actions
  module ValeraActions
    class Based
      def initialize(stats, valera)
        @stats = stats
        @valera = valera
      end

      def set_health
        @valera.health += @stats['health'].nil? ? 0 : @stats['health']
      end

      def set_mana
        @valera.mana += @stats['mana'].nil? ? 0 : @stats['mana']
        @valera.mana = @valera.mana.negative? ? 0 : @valera.mana
      end

      def set_positive
        @valera.positive += @stats['positive'].nil? ? 0 : @stats['positive']
        @valera.positive = @valera.positive >= 10 ? 10 : @valera.positive
        #@valera.positive = @valera.positive <= -10 ? -10 : @valera.positive
      end

      def set_tiredness
        @valera.tiredness += @stats['tiredness'].nil? ? 0 : @stats['tiredness']
        @valera.tiredness = @valera.tiredness >= 100 ? 100 : @valera.tiredness
        @valera.tiredness = @valera.tiredness.negative? ? 0 : @valera.tiredness
      end

      def set_money
        @valera.money += @stats['money'].nil? ? 0 : @stats['money']
      end
    end
  end
end
