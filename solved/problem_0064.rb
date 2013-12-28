require 'projectEuler'

# 3.606s (12/12/13)
class Problem_0064
  def title; 'Odd period square roots' end
  def solution; 1_322 end

  # All square roots are periodic when written as continued fractions and can
  # be written in the form:
  #
  #                            1
  #     sqrt(N) = a0 + ------------------
  #                               1
  #                    a1 + -------------
  #                                 1
  #                         a2 + --------
  #                              a3 + ...
  #
  # For example, let us consider 23:
  #
  #                                            1                 1
  #     sqrt(23) = 4 + sqrt(23) - 4 = 4 + ---------- = 4 + --------------
  #                                            1               sqrt(23)-3
  #                                       ----------       1 + ----------
  #                                       sqrt(23)-4               7
  #
  # If we continue we would get the following expansion:
  #
  #                            1
  #     sqrt(23) = 4 + ------------------- 
  #                               1 
  #                    1 + ---------------
  #                                 1
  #                        3 + -----------
  #                                   1
  #                            1 + -------
  #                                8 + ...
  #
  # The process can be summarised as follows:
  #
  #                    1        sqrt(23)+4         sqrt(23)-3
  #     a[0] = 4, ---------- = ------------- = 1 + ---------- 
  #               sqrt(23)-4         7                 7
  #
  #                    7       7(sqrt(23)+3)       sqrt(23)-3
  #     a[1] = 1, ---------- = ------------- = 3 + ---------- 
  #               sqrt(23)-3        14                 2
  #
  #                    2       2(sqrt(23)+3)       sqrt(23)-4
  #     a[2] = 3, ---------- = ------------- = 1 + ---------- 
  #               sqrt(23)-3        14                 7
  #
  #                    7       7(sqrt(23)+4)
  #     a[3] = 1, ---------- = ------------- = 8 + sqrt(23)-4
  #               sqrt(23)-4         7
  #
  #                    1         sqrt(23)+4        sqrt(23)-3
  #     a[4] = 8, ---------- = ------------- = 1 + ---------- 
  #               sqrt(23)-4         7                 7
  #
  #                    7       7(sqrt(23)+3)       sqrt(23)-3
  #     a[5] = 1, ---------- = ------------- = 3 + ---------- 
  #               sqrt(23)-3        14                 2
  #
  #                    2       2(sqrt(23)+3)       sqrt(23)-4
  #     a[6] = 3, ---------- = ------------- = 1 + ---------- 
  #               sqrt(23)-3        14                 7
  #
  #                    7       7(sqrt(23)+4)
  #     a[7] = 1, ---------- = ------------- = 8 + sqrt(23)-4 
  #               sqrt(23)-4         7
  #
  # It can be seen that the sequence is repeating. For conciseness, we use the
  # notation sqrt(23) = [4;(1,3,1,8)], to indicate that the block (1,3,1,8)
  # repeats indefinitely.
  #
  # The first ten continued fraction representations of (irrational) square
  # roots are:
  #
  #      2 = [1;(2)],         period=1
  #      3 = [1;(1,2)],       period=2
  #      5 = [2;(4)],         period=1
  #      6 = [2;(2,4)],       period=2
  #      7 = [2;(1,1,1,4)],   period=4
  #      8 = [2;(1,4)],       period=2
  #     10 = [3;(6)],         period=1
  #     11 = [3;(3,6)],       period=2
  #     12 = [3;(2,6)],       period=2
  #     13 = [3;(1,1,1,1,6)], period=5
  #
  # Exactly four continued fractions, for N <= 13, have an odd period.
  #
  # How many continued fractions for N <= 10000 have an odd period?

  def solve( n = 10_000 )
    (0..n).select {|i| i.sqrt_cf.count % 2 == 0}.count
  end
end
