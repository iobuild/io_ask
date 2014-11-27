require 'active_support/core_ext/kernel/singleton_class'

require "io_ask/engine"


module IoAsk

  mattr_accessor :user_class, :category_class, :layout, :avatar_user_method


  class << self


    def decorate_user_class!
      IoAsk.user_class.class_eval do

        has_many :topics, :class_name => "IoAsk::Topic", :foreign_key => "user_id"
   
        
        # Using +to_s+ by default for backwards compatibility
        def ioask_name
          to_s
        end unless method_defined? :ioask_name

        # Using +email+ by default for backwards compatibility. This attribute
        # it's optional
        def ioask_email
          try :email
        end unless method_defined? :ioask_email
      end
    end

    def user_class
      if @@user_class.is_a?(Class)
        raise "You can no longer set IoAsk.user_class to be a class. Please use a string instead.\n\n "
      elsif @@user_class.is_a?(String)
        begin
          Object.const_get(@@user_class)
        rescue NameError
          @@user_class.constantize
        end
      end
    end


    def category_class
      if @@category_class.is_a?(Class)
        raise "You can no longer set IoAsk.category_class to be a class. Please use a string instead.\n\n "
      elsif @@category_class.is_a?(String)
        begin
          Object.const_get(@@category_class)
        rescue NameError
          @@category_class.constantize
        end
      end
    end


    def layout
      @@layout || "io_ask/application"
    end


  end

end
