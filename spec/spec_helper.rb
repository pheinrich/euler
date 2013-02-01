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