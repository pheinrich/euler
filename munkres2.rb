class Munkres2
  Label = Struct.new( :job, :worker )
  Match = Struct.new( :job, :worker )
  Slack = Struct.new( :value, :worker )

  # https://github.com/KevinStern/software-and-algorithms/blob/master/src/main/java/blogspot/software_and_algorithms/stern_library/optimization/HungarianAlgorithm.java
  def minimize_cost( matrix )
    @matrix = matrix.map( &:dup )
    
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
    @label = @matrix.map {|row| Label.new( row.min, 0 )} 

    # Find a valid matching by greedily selecting among zero-cost matchings.
    # This is a heuristic to jump-start the augmentation algorithm.
    @match = @matrix.map {Match.new( -1, -1 )}
    @matrix.each_index do |w|
      @matrix.each_index do |j|
        @match[w].job, @match[j].worker = j, w if -1 == @match[w].job &&
                                                  -1 == @match[j].worker &&
                                                   0 == @matrix[w][j] - @label[w].worker - @label[j].job
      end
    end
 
    # While there are still unassigned workers, try to find augmenting paths
    # that will allow better assignments.  
    w = @match.index {|m| -1 == m.job}
    while w
      find_matching( w )
      
      # Keep going as long as there are unassigned workers.
      w = @match.index {|m| -1 == m.job}
    end

    @match.map {|m| m.job}
  end
  
  def maximize_profit( matrix )
    # Convert each element from an edge weight to an edge cost. 
    max = matrix.flatten.max
    minimize_cost( matrix.map {|row| row.map {|c| max - c}} )
  end
    
  protected

  def find_matching( w )
    committedWorkers = (0...@matrix.size).map {|idx| idx == w}
    parentWorkerByCommittedJob = @matrix.map {-1}
    minSlack = (0...@matrix.size).map {|j| Slack.new( @matrix[w][j] - @label[w].worker - @label[j].job, w)}

    while true do
      slack = Slack.new( Float::INFINITY, -1 )
      job = -1
 
      parentWorkerByCommittedJob.each_with_index do |parent, j|
        if -1 == parent && minSlack[j].value < slack.value
          slack = minSlack[j].dup
          job = j
        end 
      end
      
      if 0 < slack.value
        # Update labels with the specified slack by adding the slack value for
        # committed workers and by subtracting the slack value for committed jobs.
        # In addition, update the minimum slack values appropriately.
        committedWorkers.each_with_index {|busy, w| @label[w].worker += slack.value if busy}
        parentWorkerByCommittedJob.each_with_index do |parent, j|
          if -1 == parent
            minSlack[j].value -= slack.value
          else
            @label[j].job -= slack.value
          end
        end
      end

      parentWorkerByCommittedJob[job] = slack.worker;

      if -1 == @match[job].worker
        # An augmenting path has been found.
        committedJob = job
        while -1 != committedJob
          parentWorker = parentWorkerByCommittedJob[committedJob]
          temp = @match[parentWorker].job

          @match[parentWorker].job = committedJob
          @match[committedJob].worker = parentWorker
          committedJob = temp
        end
        
        return
      else
        # Update slack values since we increased the size of the committed
        # workers set.
        worker = @match[job].worker
        committedWorkers[worker] = true
        
        parentWorkerByCommittedJob.each_with_index do |parent, j|
          next if -1 != parent
          
          value = @matrix[worker][j] - @label[worker].worker - @label[j].job
          minSlack[j] = Slack.new( value, worker ) if minSlack[j].value > value
        end
      end
    end
  end
end
