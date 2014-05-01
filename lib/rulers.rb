require "rulers/version"
require "rulers/routing"

module Rulers
  class Application
  	def call(env)
  	  if env['PATH_INFO'] == '/favicon.ico'
  	  	return [404, 
  	  		{'Content-Type' => 'text/html'}, []]
  	  elsif env['PATH_INFO'] == '/'
  	  	return [302, {'Location' => '/quotes/a_quote'}, ['redirecting']]
  	  end

  	  klass, act = get_controller_and_action(env)
  	  controller = klass.new(env)
  	  begin
  	    text = controller.send(act)
  	    [200, {'Content-Type' => 'text/html'},
          [text]]
      rescue Exception => e
      	[500, {'Content-Type' => 'text/html'},
          ["Error"]]
      end
  	end
  end

  class Controller

  	def initialize(env)
  	  @env = env
  	end

  	def env
  	  @env
  	end

  end
end
