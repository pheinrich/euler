require 'projectEuler'
require 'ruby-prof'

$LOAD_PATH.unshift File.expand_path( './../solved', __FILE__ )

for i in [129]
#for i in [158, 164, 172, 191, 345]
  require "problem_%04d" % i
 
  problem = Object::const_get( "Problem_%04d" % i ).new
  puts "Problem %d: %s" % [i, problem.title]

  ProjectEuler.time do
#    result = RubyProf.profile do
      sol = problem.solve.to_s
      puts "#{sol} (#{[sol].pack( 'm0' )})"
#    end

#    printer = RubyProf::GraphPrinter.new( result )
#    printer.print( STDOUT, {} )
  end
end
