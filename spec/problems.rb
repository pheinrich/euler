require 'spec_helper'

1.upto( 87 ) do |i|
  require "problem_%04d" % i
  problem = Object::const_get( "Problem_%04d" % i ).new

  describe "Problem %d: %s" % [i, problem.title] do
    describe '.solve' do
      it problem.solution do
        problem.solve.should == problem.solution
      end
    end
  end
end
