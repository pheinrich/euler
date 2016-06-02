require 'projectEuler'

# 
class Problem_0345
  def title; 'Matrix Sum' end
  def solution;  end

  # We define the Matrix Sum of a matrix as the maximum sum of matrix elements
  # with each element being the only one in his row and column. For example,
  # the Matrix Sum of the matrix below equals 3315 ( = 863 + 383 + 343 + 959 +
  # 767):
  #
  #         7    53   183   439  [863]
  #       497  [383]  563    79   973
  #       287    63  [343]  169   583
  #       627   343   773  [959]  943
  #      [767]  473   103   699   303
  #
  # Find the Matrix Sum of:
  #
#  N = '  7  53 183 439 863 497 383 563  79 973 287  63 343 169 583 ' \
#      '627 343 773 959 943 767 473 103 699 303 957 703 583 639 913 ' \
#      '447 283 463  29  23 487 463 993 119 883 327 493 423 159 743 ' \
#      '217 623   3 399 853 407 103 983  89 463 290 516 212 462 350 ' \
#      '960 376 682 962 300 780 486 502 912 800 250 346 172 812 350 ' \
#      '870 456 192 162 593 473 915  45 989 873 823 965 425 329 803 ' \
#      '973 965 905 919 133 673 665 235 509 613 673 815 165 992 326 ' \
#      '322 148 972 962 286 255 941 541 265 323 925 281 601  95 973 ' \
#      '445 721  11 525 473  65 511 164 138 672  18 428 154 448 848 ' \
#      '414 456 310 312 798 104 566 520 302 248 694 976 430 392 198 ' \
#      '184 829 373 181 631 101 969 613 840 740 778 458 284 760 390 ' \
#      '821 461 843 513  17 901 711 993 293 157 274  94 192 156 574 ' \
#      ' 34 124   4 878 450 476 712 914 838 669 875 299 823 329 699 ' \
#      '815 559 813 459 522 788 168 586 966 232 308 833 251 631 107 ' \
#      '813 883 451 509 615  77 281 613 459 205 380 274 302  35 805'.split.map( &:to_i ).each_slice( 15 ).to_a
  N = '  7  53 183 439 863 ' \
      '497 383 563  79 973 ' \
      '287  63 343 169 583 ' \
      '627 343 773 959 943 ' \
      '767 473 103 699 303'.split.map( &:to_i ).each_slice( 5 ).to_a

  def refs
    ["http://en.wikipedia.org/wiki/Assignment_problem",
     "http://en.wikipedia.org/wiki/Hungarian_algorithm",
     "http://www.hungarianalgorithm.com/solve.php",
     "http://www.mathcs.emory.edu/~cheung/Courses/323/Syllabus/Assignment/algorithm.html",
     "http://csclab.murraystate.edu/bob.pilgrim/445/munkres.html",
     "https://github.com/pdamer/munkres",
     "https://code.google.com/p/or-tools/source/browse/trunk/src/algorithms/hungarian.cc",
     "https://www.ri.cmu.edu/pub_files/pub4/mills_tettey_g_ayorkor_2007_3/mills_tettey_g_ayorkor_2007_3.pdf"]
  end
 
  def solution; 13_938 end
  def best_time; end

  def completed_on; '2015-03-27' end
  def ordinality; 2_306 end
  def population; 473_729 end

  def solve( w = 5 )
    km = ProjectEuler::KuhnMunkres.new( N )
    puts km.minimize_cost.inspect
  end
end
