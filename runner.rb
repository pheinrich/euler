require 'projectEuler'

$LOAD_PATH.unshift File.expand_path( './../solved', __FILE__ )

for i in [77]
  require "problem_%04d" % i
 
  problem = Object::const_get( "Problem_%04d" % i ).new
  puts "Problem %d: %s" % [i, problem.title]

  ProjectEuler.time do
    puts problem.solve
  end
end
