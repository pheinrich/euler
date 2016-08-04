require 'projectEuler'

class Problem_0186
  def title; 'Connectedness of a network' end
  def difficulty; 60 end

  # Here are the records from a busy telephone system with one million users:
  #
  #   RecNr  Caller  Called
  #     1    200007  100053
  #     2    600183  500439
  #     3    600863  701497
  #    ...      ...     ...
  #
  # The telephone number of the caller and the called number in record n are
  # Caller(n) = S_(2n-1) and Called(n) = S_2n where S_(1,2,3,...) come from
  # the "Lagged Fibonacci Generator":
  #
  #   For 1 ≤ k ≤ 55, S_k = [100003 - 200003k + 300007k^3] (modulo 1000000)
  #   For 56 ≤ k, S_k = [S_(k-24) + S_(k-55)] (modulo 1000000)
  #
  # If Caller(n) = Called(n) then the user is assumed to have misdialed and
  # the call fails; otherwise the call is successful.
  #
  # From the start of the records, we say that any pair of users X and Y are
  # friends if X calls Y or vice-versa. Similarly, X is a friend of a friend
  # of Z if X is a friend of Y and Y is a friend of Z; and so on for longer
  # chains.
  #
  # The Prime Minister's phone number is 524287. After how many successful
  # calls, not counting misdials, will 99% of the users (including the PM) be
  # a friend, or a friend of a friend etc., of the Prime Minister?

  @@k = 0
  @@fib = [200007, 100053, 600183, 500439, 600863, 701497, 602383, 103563,
             5079, 106973, 209287, 112063, 615343, 519169, 623583, 728627,
           634343, 140773,  47959, 155943, 264767, 174473, 685103, 596699,
           709303, 822957, 737703, 253583, 170639, 288913, 408447, 329283,
           851463, 775029, 900023,  26487, 954463, 483993, 415119, 547883,
           682327, 618493, 156423,  96159, 237743, 381217, 326623, 874003,
           823399, 974853, 128407,  84103, 641983, 602089, 764463]

  # Lagged Fibonacci Congruential Generator based on [24, 55]. This method
  # uses a pre-initialized table, which it updates as it cycles.
  def lagged_fib
    value = @@fib[@@k]
    
    @@fib[@@k] = (@@fib[(@@k - 24) % 55] + @@fib[(@@k - 55) % 55]) % 1_000_000
    @@k = (1 + @@k) % 55
    
    value
  end

  # Tag a user and all of their connections as friends of the PM. Do this
  # iteratively to avoid stack overflow, since it's conceivable that as many
  # as 1M nested calls may be required (worst case).
  def add_friends( whose, conn, friends )
    friends[whose] = true
    links = conn.delete( whose )
    return unless links

    # We added the user; now add all of their connections. Tack them on to the
    # end of the list (dropping duplicates) as we run through it, so they will
    # be similarly processed in turn. We must continue to make passes through
    # the list until it stopped growing, at which point we know we've added
    # all the friends and friends of friends of the first user. 
    count = 0
    until count == links.size
      count = links.size

      links.keys.each do |link|
        sublinks = conn.delete( link )
        links.merge!( sublinks ) if sublinks
      end
    end    

    # Now that we have the definitive list of this user's connections (and
    # their connections), tag them all as friends of the PM.
    friends.merge!( links )
  end

  def solve( pm = 524_287, limit = 99 )
    # We need to track an individual call chain only as long as no one in-
    # cluded on it is a friend or friend-of-a-friend of the PM. After that,
    # the other side of any call that includes them gets tagged immediately.
    #
    # So, for every (valid) call, first determine if either party is already
    # tagged. If not, simply record the connection. If so, tag the other
    # participant and all of their friends, identified by connections made
    # earlier and which can now be deleted.
    friends, conn = {}, Hash.new {|hash, key| hash[key] = {}}

    calls = 0
    limit *= 10_000
    friends[pm] = true

    while friends.size < limit
      from, to = lagged_fib, lagged_fib

      # Ignore misdials.
      if from != to
        calls += 1

        if friends[ from ]
          if friends[ to ]
            # Both 'from' and 'to' are already connections, so there's nothing
            # for us to do.
          else
            # 'to' is a new connection, as are all of to's connections.
            add_friends( to, conn, friends )
          end
        elsif friends[ to ]
          # 'from' is a new connection, as are all of from's connections.
          add_friends( from, conn, friends )
        else
          # Neither 'from' nor 'to' are connections, and neither are any of
          # their (current) connections. Remember them, though, in case later
          # calls connect them to existing friends.
          conn[from][to] = true
          conn[to][from] = true
        end
      end
    end
    
    calls
  end

  def solution; 'MjMyNTYyOQ==' end
  def best_time; 11.55 end
  def effort; 35 end

  def completed_on; '2016-08-04' end
  def ordinality; 1_959 end
  def population; 619_481 end

  def refs; [] end
end
