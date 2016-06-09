require 'projectEuler'
require 'ruby-prof'

$LOAD_PATH.unshift File.expand_path( './../solved', __FILE__ )

for i in [103, 105, 106]
#for i in [158, 164, 172, 191, 345]
  require "problem_%04d" % i
 
  problem = Object::const_get( "Problem_%04d" % i ).new
  puts "Problem %d: %s" % [i, problem.title]

  ProjectEuler.time do
#    result = RubyProf.profile do
      puts problem.solve
#    end

#    printer = RubyProf::GraphPrinter.new( result )
#    printer.print( STDOUT, {} )
  end
end
