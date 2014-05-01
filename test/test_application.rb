require_relative "test_helper"

class TestApp < Rulers::Application
  
  class RulersAppTest < Test::Unit::TestCase
  	include Rack::Test::Methods

  	def app
  	  TestApp.new
  	end

  	def test_request
  	  get "/"
  	  assert last_response.ok?
  	  body= last_response.body
  	  assert body["Hello"]
  	end

  	def test_request_content_type
  	  get "/"
  	  asserft last_response.content_type['text/html']
  	end

  end
end