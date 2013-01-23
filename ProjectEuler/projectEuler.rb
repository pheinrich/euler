module ProjectEuler
  def self.time
    start = Time.now.to_f
    yield
    puts "%.10f%c" % [Time.now.to_f - start, 's']
  end
end