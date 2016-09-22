# Algorithm SM-2 used in the computer-based variant of the SuperMemo method and
# involving the calculation of easiness factors for particular items:
# http://www.supermemo.com/english/ol/sm2.htm
class SuperMemo
  class << self
    def algorithm(interval, repeat, efactor, attempt, distance)
      quality = set_quality(attempt, distance)
      efactor = set_efactor(efactor, quality)
      sm_hash = if quality >= 3
                  set_interval(interval, repeat + 1, efactor)
                else
                  set_interval(interval, 1, efactor)
                end
      sm_hash.merge!(quality: quality)
    end

    def set_interval(interval, repeat, efactor)
      interval = case repeat
                 when 1 then 1
                 when 2 then 6
                 else (interval * efactor).round
                 end
      { interval: interval, efactor: efactor, repeat: repeat }
    end

    def set_efactor(efactor, quality)
      efactor += (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
      efactor < 1.3 ? 1.3 : efactor
    end

    def set_quality(attempt, distance)
      diff = distance <= 1 ? 0 : 3
      case attempt
      when 1 then 5 - diff
      when 2 then 4 - diff
      else 3 - diff
      end
    end
  end
end
