module IoAsk
  class Engine < ::Rails::Engine
    isolate_namespace IoAsk

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end
    
  end
end


require 'bootstrap-sass'