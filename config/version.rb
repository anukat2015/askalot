module Askalot
  module VERSION
    MAJOR = 2
    MINOR = 1
    PATCH = 4

    PRE = 'alpha'

    STRING = [MAJOR, MINOR, PATCH, PRE].compact.join '.'
  end
end
