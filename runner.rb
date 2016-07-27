require 'projectEuler'

$LOAD_PATH.unshift File.expand_path( './../solved', __FILE__ )

for i in [*1..566]
  begin
    require "problem_%04d" % i
 
    problem = Object::const_get( "Problem_%04d" % i ).new
    puts "Problem #{i}: #{problem.title}"

    ProjectEuler.time do
      sol = problem.solve.to_s
      puts "#{sol} (#{[sol].pack( 'm0' )})"
    end
  rescue LoadError
    puts "Could not find problem #{i} — skipping"
  end
end
