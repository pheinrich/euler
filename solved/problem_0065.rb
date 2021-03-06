require 'projectEuler'

class Problem_0065
  def title; 'Convergents of e' end
  def difficulty; 15 end

  # The square root of 2 can be written as an infinite continued fraction.
  #
  #                            1
  #     sqrt(2) = 1 + -------------------
  #                              1
  #                   2 + ---------------
  #                                1
  #                       2 + -----------
  #                                  1
  #                           2 + -------
  #                               2 + ...
  #
  # The infinite continued fraction can be written, sqrt(2) = [1;(2)], (2)
  # indicates that 2 repeats ad infinitum. In a similar way, sqrt(23) =
  # [4;(1,3,1,8)].
  #
  # It turns out that the sequence of partial values of continued fractions
  # for square roots provide the best rational approximations. Let us consider
  # the convergents for sqrt(2).
  #
  #          1
  #     1 + --- = 3/2 
  #          2
  #
  #            1
  #     1 + ------- = 7/5
  #              1
  #         2 + ---  
  #              2
  #
  #              1
  #     1 + ----------- = 17/12
  #                1
  #         2 + -------
  #                  1
  #             2 + ---
  #                  2
  #
  #                 1
  #     1 + ---------------- = 41/29
  #                   1
  #         2 + ------------
  #                     1
  #             2 + --------
  #                       1
  #                  2 + ---
  #                       2
  #
  # Hence the sequence of the first ten convergents for sqrt(2) are:
  #
  #     1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985,
  #     3363/2378, ...
  #
  # What is most surprising is that the important mathematical constant,
  # e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].
  #
  # The first ten terms in the sequence of convergents for e are:
  #
  #     2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...
  #
  # The sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.
  #
  # Find the sum of digits in the numerator of the 100th convergent of the
  # continued fraction for e.

  def solve( n = 100 )
    e = [2, 1]
    k = 1

    # Build a continued fraction for e with at least n partials.
    while e.length < n
      e << 2*k << 1 << 1
      k += 1
    end

    e.convergent( n - 1 ).numerator.sum_digits
  end

  def solution; 'Mjcy' end
  def best_time; 0.0001793 end
  def effort; 20 end
  
  def completed_on; '2013-12-12' end
  def ordinality; 14_097 end
  def population; 377_064 end

  def refs
    ['https://en.wikipedia.org/wiki/Generalized_continued_fraction']
  end
end
