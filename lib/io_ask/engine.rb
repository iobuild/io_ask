module IoAsk
  class Engine < ::Rails::Engine
    isolate_namespace IoAsk

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end


    config.to_prepare do
      Decorators.register! Engine.root, Rails.root
    end
    
  end
end


require 'decorators'
require 'bootstrap-sass'
require 'simple_form'
require 'font-awesome-sass'