require 'spec_helper'
require_relative '../projectEuler'

describe Integer do
  it "provides some additional integer operations" do
  end
end

describe ProjectEuler do
  it "provides general functions helpful when solving the problems" do
  end
  
  describe ".time" do
    it "should measure execution time of a block" do
      out = capture_stdout do
        ProjectEuler.time do
          # Dummy operation; likely zero elapsed time.
        end
      end

      # Output string has format "0.4105238914s\n"
      out.string.should =~ /\d+\.\d{10}s\n/
    end
  end

  describe ".eratosthenes" do
    it "should generate an array of primes" do
      array = ProjectEuler.eratosthenes( 100 )
      array.should eq( [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97] )
    end
  end

  describe ".modular_power" do
    it "should perform exponentiation over a modulus" do
      ProjectEuler.modular_power( 1234, 567, 890 ).should be( 304 )
    end
  end
end
