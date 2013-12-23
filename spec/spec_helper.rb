%w(../.. ../../solved).each {|path| $LOAD_PATH.unshift File.expand_path( path, __FILE__ )}

require 'stringio'

module Kernel
  # Allow puts/print redirection to a string.
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end
end