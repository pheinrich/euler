class Munkres < Array
  def initialize( matrix )
    super( matrix )

    # Pad the matrix if necessary (it should be square).
    self.map! {|row| row + [0] * (matrix.length - row.length)}
    
    @matchJobByWorker = Array.new( self.size, -1 )
    @matchWorkerByJob = Array.new( self.size, -1 )
  end

  # https://github.com/KevinStern/software-and-algorithms/blob/master/src/main/java/blogspot/software_and_algorithms/stern_library/optimization/HungarianAlgorithm.java
  def execute
    @matrix = self.map( &:dup )
    puts "matrix: #{@matrix.inspect}"
    
    reduce
    puts "reduce: #{@matrix.inspect}"
    
    compute_initial_feasible_solution
    puts "init sol (by job):    #{@labelByJob.inspect}"
    puts "init sol (by worker): #{@labelByWorker.inspect}"
    
    greedy_match
    puts "after match (worker): #{@matchJobByWorker.inspect}"
    puts "after match (job):    #{@matchWorkerByJob.inspect}"
    
    w = fetch_unmatched_worker
    while w < self.size
      puts "  unmatched worker: #{w}"
      initialize_phase( w )
      puts "  init (committed workers): #{@committedWorkers.inspect}"
      puts "  init (parent workers):    #{@parentWorkerByCommittedJob.inspect}"
      puts "  init (min slack value):   #{@minSlackValueByJob.inspect}"
      puts "  init (min slack worker):  #{@minSlackWorkerByJob.inspect}"
      
      execute_phase
      w = fetch_unmatched_worker
    end
    
    @matchJobByWorker.map {|x| x < @matrix.size ? x : -1}.inspect
  end
  
  # Update labels with the specified slack by adding the slack value for
  # committed workers and by subtracting the slack value for committed jobs.
  # In addition, update the minimum slack values appropriately.
  def update_labeling( slack )
    @committedWorkers.each_with_index {|busy, w| @labelByWorker[w] += slack if busy}
    @parentWorkerByCommittedJob.each_with_index do |parent, j|
      if -1 == parent
        @minSlackValueByJob[j] -= slack
      else
        @labelByJob[j] -= slack
      end
    end
  end
  
  # Execute a single phase of the algorithm. A phase of the Hungarian
  # algorithm consists of building a set of committed workers and a set of
  # committed jobs from a root unmatched worker by following alternating
  # unmatched/matched zero-slack edges. If an unmatched job is encountered,
  # then an augmenting path has been found and the matching is grown. If the
  # connected zero-slack edges have been exhausted, the labels of committed
  # workers are increased by the minimum slack among committed workers and
  # non-committed jobs to create more zero-slack edges (the labels of
  # committed jobs are simultaneously decreased by the same amount in order to
  # maintain a feasible labeling).
  #
  # The runtime of a single phase of the algorithm is O(n^2), where n is the
  # dimension of the internal square cost matrix, since each edge is visited
  # at most once and since increasing the labeling is accomplished in time
  # O(n) by maintaining the minimum slack values among non-committed jobs.
  # When a phase completes, the matching will have increased in size.
  def execute_phase
    while true do
      minSlackWorker = -1
      minSlackJob = -1
      minSlackValue = Float::INFINITY
 
      @parentWorkerByCommittedJob.each_with_index do |parent, j|
        if -1 == parent && @minSlackValueByJob[j] < minSlackValue
          minSlackValue = @minSlackValueByJob[j]
          minSlackWorker = @minSlackWorkerByJob[j]
          minSlackJob = j
        end 
      end
      
      update_labeling( minSlackValue ) if 0 < minSlackValue
      @parentWorkerByCommittedJob[minSlackJob] = minSlackWorker;
      
      if -1 == @matchWorkerByJob[minSlackJob]
        # An augmenting path has been found.
        committedJob = minSlackJob
        while -1 != committedJob
          parentWorker = @parentWorkerByCommittedJob[committedJob]
          temp = @matchJobByWorker[parentWorker]
          match( parentWorker, committedJob )
          committedJob = temp
        end
        
        return
      else
        # Update slack values since we increased the size of the committed
        # workers set.
        worker = @matchWorkerByJob[minSlackJob]
        @committedWorkers[worker] = true
        
        @parentWorkerByCommittedJob.each_with_index do |parent, j|
          next if -1 != parent
          
          slack = @matrix[worker][j] - @labelByWorker[worker] - @labelByJob[j]
          if @minSlackValueByJob[j] > slack
            @minSlackValueByJob[j] = slack
            @minSlackWorkerByJob[j] = worker
          end
        end
      end
    end
  end
  
  # Initialize the next phase of the algorithm by clearing the committed
  # workers and jobs sets and by initializing the slack arrays to the values
  # corresponding to the specified root worker.
  def initialize_phase( w )
    @committedWorkers = (0...@matrix.size).map {|idx| idx == w}
    @parentWorkerByCommittedJob = @matrix.map {-1}
    @minSlackValueByJob = (0...@matrix.size).map {|j| @matrix[w][j] - @labelByWorker[w] - @labelByJob[j]}
    @minSlackWorkerByJob = @matrix.map {w}
  end

  # Return the first unmatched worker or @matrix.size if none.
  def fetch_unmatched_worker
    @matchJobByWorker.index( -1 ) || @matrix.size
  end
  
  # Helper method to record a matching between worker w and job j.
  def match( w, j )
    @matchJobByWorker[w] = j
    @matchWorkerByJob[j] = w
  end

  # Find a valid matching by greedily selecting among zero-cost matchings.
  # This is a heuristic to jump-start the augmentation algorithm.
  def greedy_match
    self.each_index do |w|
      self.each_index do |j|
        match( w, j ) if -1 == @matchJobByWorker[w] &&
                         -1 == @matchWorkerByJob[j] &&
                          0 == @matrix[w][j] - @labelByWorker[w] - @labelByJob[j]
      end
    end
  end
  
  # Compute an initial feasible solution by assigning zero labels to the
  # workers and by assigning to each job a label equal to the minimum cost
  # among its incident edges.
  def compute_initial_feasible_solution
    @labelByJob = @matrix.map {|row| row.min}
    @labelByWorker = @matrix.map {0}
  end

  # Reduce the cost matrix by subtracting the smallest element of each row
  # from all elements of the row as well as the smallest element of each
  # column from all elements of the column. Note that an optimal assignment
  # for a reduced cost matrix is optimal for the original cost matrix.
  def reduce
    # Reduce each row by its minimum value.
    @matrix.map! do |row|
      min = row.min
      row.map {|c| c - min}
    end

    # Reduce each column by its minimum value.
    @matrix = @matrix.transpose.map do |col|
      min = col.min
      col.map {|c| c - min}
    end.transpose
  end
end