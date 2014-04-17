require "rulers/version"
require "rulers/array"
require "rulers/string"

module Rulers
  class Application
  	def call(env)
  	  `echo debug > debug.txt`;
  	  [200, {'Content-Type' => 'text/html'},
        ["Hello from Ruby on Rulers".exclamify(5)]]
  	end
  end
end
