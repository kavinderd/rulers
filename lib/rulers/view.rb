module Rulers
  class View
  	attr_accessor :template, :attributes
  	def initialize(options={})
  	  controller = options.fetch(:controller)
  	  filename = File.join "app", "views", controller.controller_name, "#{options.fetch(:action)}.html.erb"
  	  @template = File.read filename
  	  @eruby = Erubis::Eruby.new(@template)
  	  set_instance_variables(options.fetch(:controller))
  	end

  	def render
  	  locals = prepare_locals
  	  @eruby.result locals
  	end

    private

    def set_instance_variables(controller)
      @attributes = []
      controller.instance_variables.each do |var|
      	puts var
      	@attributes << "#{var}"
        self.instance_variable_set("#{var}", controller.instance_variable_get(var))
      end
    end

    def prepare_locals
      locals = {}
      @attributes.each do |attribute|
      	locals[attribute] = self.instance_variable_get(attribute)
      end
      locals
    end
  end
end