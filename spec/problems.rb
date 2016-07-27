require 'spec_helper'

skipped = []
1.upto( 566 ) do |i|
  begin
    require "problem_%04d" % i
    problem = Object::const_get( "Problem_%04d" % i ).new

    describe "Problem %d: %s" % [i, problem.title] do
      describe '.solve' do
        it problem.solution do
          expect( [problem.solve.to_s].pack( 'm0' ) ).to  eq( problem.solution || '' )
        end
      end
    end
  rescue LoadError
    skipped << i
  end
end

puts "Some problem tests could not be found, and were skipped" unless skipped.empty?
