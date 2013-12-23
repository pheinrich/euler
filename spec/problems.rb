require 'spec_helper'
n = 7
n.upto(n) do |i|
  require "problem_%04d" % i
  problem = Object::const_get( "Problem_%04d" % i ).new

  describe problem do
    describe ".solve" do
      it problem.title do
        problem.solve.should == problem.solution
      end
    end
  end
end
