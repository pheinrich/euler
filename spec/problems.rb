require 'spec_helper'

81.upto( 83 ) do |i|
  require "problem_%04d" % i
  problem = Object::const_get( "Problem_%04d" % i ).new

  describe "Problem %d: %s" % [i, problem.title] do
    describe '.solve' do
      it problem.solution do
        expect( problem.solve ).to  eq( problem.solution )
      end
    end
  end
end
