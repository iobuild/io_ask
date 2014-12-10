require 'rails/generators'
module IoAsk
  module Generators
    class ViewsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../../app/views/io_ask", __FILE__)
      desc "Used to copy io_ask's views to your application's views."

      def copy_views
        view_directory :comments
        view_directory :topics
      end

      protected

      def view_directory(name)
        directory name.to_s, "app/views/io_ask/#{name}"
      end
    end
  end
end
