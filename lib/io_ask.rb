require "io_ask/engine"

module IoAsk

  mattr_accessor :user_class, :category_class, :layout


  class << self

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
      @@layout || "forem/default"
    end


  end

end
