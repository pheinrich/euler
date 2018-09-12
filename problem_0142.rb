require 'projectEuler'

class Problem_0142
  def title; 'Perfect Square Collection' end
  def difficulty; 45 end

  # Find the smallest x + y + z with integers x > y > z > 0 such that x + y,
  # x − y, x + z, x − z, y + z, y − z are all perfect squares.

  SQUARES = (1..10_000).map {|i| i*i}
  sums = {}
  difs = {}

  def genx
    sums = {}
    difs = {}

    (0...(SQUARES.length-1)).each do |i|
      ((i+1)...SQUARES.length).each do |j|
        s = SQUARES[j] + SQUARES[i]
        sums[s] = [] unless sums.has_key?( s )
        sums[s] << [SQUARES[j], SQUARES[i]]

        d = SQUARES[j] - SQUARES[i]
        difs[d] = [] unless difs.has_key?( d )
        difs[d] << [SQUARES[j], SQUARES[i]]
      end
    end

    sums.select! {|k, v| v.length > 1}
    difs.select! {|k, v| v.length > 1}

    puts sums.length
    puts difs.length
  end

  def solve( n = 1_000_000 )
    genx
  end

  def solution; '' end
  def best_time; 1 end
  def effort; 45 end

  def completed_on; '20??-??-??' end
  def ordinality; 1 end
  def population; 1 end

  def refs
    [ 'https://math.stackexchange.com/a/153684' ]
  end
end
