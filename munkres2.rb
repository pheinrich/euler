class Munkres2 < Array
  Label = Struct.new( :job, :worker )
  Match = Struct.new( :job, :worker )
  Slack = Struct.new( :value, :worker )

  def initialize( matrix )
    super( matrix )

    # Pad the matrix if necessary (it should be square).
    self.map! {|row| row + [0] * (matrix.length - row.length)}
  end

  # https://github.com/KevinStern/software-and-algorithms/blob/master/src/main/java/blogspot/software_and_algorithms/stern_library/optimization/HungarianAlgorithm.java
  def minimize_cost( matrix = nil )
    @matrix = matrix || self.map( &:dup )
    
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

    # Compute an initial feasible solution by assigning zero labels to the
    # workers and by assigning to each job a label equal to the minimum cost
    # among its incident edges.
    @match = Array.new( self.size ) {Match.new( -1, -1 )}
    @label = @matrix.map {|row| Label.new( row.min, 0 )} 

    # Find a valid matching by greedily selecting among zero-cost matchings.
    # This is a heuristic to jump-start the augmentation algorithm.
    self.each_index do |w|
      self.each_index do |j|
        @match[w].job, @match[j].worker = j, w if -1 == @match[w].job &&
                                                  -1 == @match[j].worker &&
                                                   0 == @matrix[w][j] - @label[w].worker - @label[j].job
      end
    end
  
    w = @match.index {|m| -1 == m.job}
    while w
      @committedWorkers = (0...@matrix.size).map {|idx| idx == w}
      @parentWorkerByCommittedJob = @matrix.map {-1}
      @minSlack = (0...@matrix.size).map {|j| Slack.new( @matrix[w][j] - @label[w].worker - @label[j].job, w)}

      find_matching
      w = @match.index {|m| -1 == m.job}
    end
    
    @match.each_with_index.reduce( 0 ) {|acc, (j, i)| acc + self[i][j.job]}
  end
  
  def maximize_profit
    # Convert each element from an edge weight to an edge cost. 
    max = self.flatten.max
    minimize_cost( self.map {|row| row.map {|c| max - c}} )
  end
    
  protected
  
  # Update labels with the specified slack by adding the slack value for
  # committed workers and by subtracting the slack value for committed jobs.
  # In addition, update the minimum slack values appropriately.
  def update_labeling( slack )
    @committedWorkers.each_with_index {|busy, w| @label[w].worker += slack if busy}
    @parentWorkerByCommittedJob.each_with_index do |parent, j|
      if -1 == parent
        @minSlack[j].value -= slack
      else
        @label[j].job -= slack
      end
    end
  end
  
  def find_matching
    while true do
      minSlack = Slack.new( Float::INFINITY, -1 )
      minSlackJob = -1
 
      @parentWorkerByCommittedJob.each_with_index do |parent, j|
        if -1 == parent && @minSlack[j].value < minSlack.value
          minSlack.value = @minSlack[j].value
          minSlack.worker = @minSlack[j].worker
          minSlackJob = j
        end 
      end
      
      update_labeling( minSlack.value ) if 0 < minSlack.value
      @parentWorkerByCommittedJob[minSlackJob] = minSlack.worker;

      if -1 == @match[minSlackJob].worker
        # An augmenting path has been found.
        committedJob = minSlackJob
        while -1 != committedJob
          parentWorker = @parentWorkerByCommittedJob[committedJob]
          temp = @match[parentWorker].job

          @match[parentWorker].job = committedJob
          @match[committedJob].worker = parentWorker
          committedJob = temp
        end
        
        return
      else
        # Update slack values since we increased the size of the committed
        # workers set.
        worker = @match[minSlackJob].worker
        @committedWorkers[worker] = true
        
        @parentWorkerByCommittedJob.each_with_index do |parent, j|
          next if -1 != parent
          
          slack = @matrix[worker][j] - @label[worker].worker - @label[j].job
          @minSlack[j] = Slack.new( slack, worker ) if @minSlack[j].value > slack
        end
      end
    end
  end
end
