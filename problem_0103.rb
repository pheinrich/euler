require 'projectEuler'

# 
class Problem_0103
  def title; 'Special subset sums: optimum' end
  def difficulty; 45 end

  # Let S(A) represent the sum of elements in set A of size n. We shall call
  # it a special sum set if for any two non-empty disjoint subsets, B and C,
  # the following properties are true:
  #
  #      i.  S(B) ≠ S(C); that is, sums of subsets cannot be equal.
  #      ii. If B contains more elements than C then S(B) > S(C).
  #
  # If S(A) is minimised for a given n, we shall call it an optimum special
  # sum set. The first five optimum special sum sets are given below.
  #
  #      n = 1: {1}
  #      n = 2: {1, 2}
  #      n = 3: {2, 3, 4}
  #      n = 4: {3, 5, 6, 7}
  #      n = 5: {6, 9, 11, 12, 13}
  #
  # It seems that for a given optimum set, A = {a_1, a_2, ... , a_n}, the next
  # optimum set is of the form B = {b, a_1+b, a_2+b, ... ,a_n+b}, where b is
  # the "middle" element on the previous row.
  #
  # By applying this "rule" we would expect the optimum set for n = 6 to be
  # A = {11, 17, 20, 22, 23, 24}, with S(A) = 117. However, this is not the
  # optimum set, as we have merely applied an algorithm to provide a near opt-
  # imum set. The optimum set for n = 6 is A = {11, 18, 19, 20, 22, 25}, with
  # S(A) = 115 and corresponding set string: 111819202225.
  #
  # Given that A is an optimum special sum set for n = 7, find its set string.
  #
  # NOTE: This problem is related to Problem 105 and Problem 106.

  def special( arr )
    sorted = arr.sort
    sums = {}
  end

  def check_sums( arr )
    sums = {}
    max = 1 << arr.size

    (1...max).each do |i|
      mask = i
      sum = 0
      j = 0
      while 0 < mask
        sum += arr[j] if 1 == mask & 1
        mask >>= 1
        j += 1
      end
      
      return true if sums[sum]
      sums[sum] = true
    end
    
    false
  end

  def solve( n = 5 )#7 )
    # A few observations following directly from properties i and ii (assume
    # w.l.o.g. that A is ordered):
    #
    #   1. a_i must be unique, so a_n > a_1 + n - 2.
    #   2. a_1 + a_2 > a_n, so a_1 + a_2 > a_1 + n - 2 ==> a_2 > n - 2.
    #   3. a_2 >= n - 1 ==> a_2 - a_1 >= n - 1 - a_1
    #   4. a_i + a_j != a_k ∀ i, j, k, so a_k - a_j ∉ A for any j, k.

    for a_1 in (20..30)
      mn2, mx2 = a_1+1, 2*a_1
      
      for a_2 in (mn2...mx2)
        mn3, mx3 = a_2+1, a_1+a_2
        break if mn3 > mx3
        
        for a_3 in (mn3...mx3)
          mn4, mx4 = a_3+1, a_1+a_2
          if mn4 > mx4
#            puts "mn4 > mx4"
            break
          end
          
          for a_4 in (mn4...mx4)
            mn5, mx5 = a_4+1, a_1+a_2
            break if mn5 > mx5
            
            for a_5 in (mn5...mx5)
              mn6, mx6 = a_5+1, a_1+a_2
              break if mn5 > mx5
              break unless a_4+a_5 < a_1+a_2+a_3

              for a_6 in (mn6...mx6)
                mn7, mx7 = a_6+1, a_1+a_2
                break if mn7 > mx7
                break unless a_5+a_6 < a_1+a_2+a_3

                for a_7 in (mn7...mx7)
                 break unless a_6+a_7 < a_1+a_2+a_3
                 break unless a_5+a_6+a_7 < a_1+a_2+a_3+a_4

                 if check_sums( [a_1, a_2, a_3, a_4, a_5, a_6, a_7] )
#                   puts "check_sums"
#                   puts "  #{[a_1, a_2, a_3, a_4, a_5, a_6, a_7].inspect}"
                   break
                 end

                  puts "---> #{[a_1, a_2, a_3, a_4, a_5, a_6, a_7].inspect}   =   #{[a_1, a_2, a_3, a_4, a_5, a_6, a_7].reduce(:+)}"
                end
              end
            end
          end
        end
      end
    end
  end

  def solution; end
  def best_time; end
  def effort; end

  def completed_on; '2016-01-01' end
  def ordinality; end
  def population; end

  def refs
    ["http://people.maths.ox.ac.uk/greenbj/papers/bourgain-sumset.pdf",
     "http://math.haifa.ac.il/~seva/Papers/DisBases.pdf",
     "http://mathoverflow.net/a/56175"]
  end
end

__END__

a1 < a2 < a3 < a4

a1 + a2 > a4
a1 + a3 == a2 + a4

0 0 0 1   a1 (7) [7]
0 0 1 0
0 1 0 0
0 1 1 0
1 0 0 0
1 0 1 0
1 1 0 0
1 1 1 0

0 0 1 0   a2 (6) [13]
#0 0 0 1
0 1 0 0
0 1 0 1
1 0 0 0
1 0 0 1
1 1 0 0
1 1 0 1

0 0 1 1   a1 + a2 (3) [16]
0 1 0 0
1 0 0 0
1 1 0 0

0 1 0 0   a3 (4) [20]
#0 0 0 1
#0 0 1 0
#0 0 1 1
1 0 0 0
1 0 0 1
1 0 1 0
1 0 1 1

0 1 0 1   a1 + a3 (2) [22]
#0 0 1 0
1 0 0 0
1 0 1 0

0 1 1 0   a2 + a3 (2) [24]
#0 0 0 1
1 0 0 0
1 0 0 1

0 1 1 1   a1 + a2 + a3 (1) [25]
1 0 0 0

1 0 0 0   a4 (0)
#0 0 0 1
#0 0 1 0
#0 0 1 1
#0 1 0 0
#0 1 0 1
#0 1 1 0
#0 1 1 1
  
1 0 0 1   a1 + a4 (0)
#0 0 1 0
#0 1 0 0
#0 1 1 0
  
1 0 1 0   a2 + a4 (0)
#0 0 0 1
#0 1 0 0
#0 1 0 1
  
1 0 1 1   a1 + a2 + a4 (0)
#0 1 0 0
  
1 1 0 0   a3 + a4 (0)
#0 0 0 1
#0 0 1 0
#0 0 1 1
    
1 1 0 1   a1 + a3 + a4 (0)
#0 0 1 0
    
1 1 1 0   a2 + a3 + a4 (0)
#0 0 0 1

1 1 1 1   a1 + a2 + a3 + a4 (0)
