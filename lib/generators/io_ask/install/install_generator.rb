# class IoAsk::InstallGenerator < Rails::Generators::NamedBase
#   source_root File.expand_path('../templates', __FILE__)
# end


require 'rails/generators'
module IoAsk
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option "user-class", :type => :string
      class_option "category-class", :type => :string
      class_option "no-migrate", :type => :boolean
      class_option "current-user-helper", :type => :string

      source_root File.expand_path("../templates", __FILE__)
      desc "Used to install io_ask"

      def install_migrations
        puts "Copying over io_ask migrations..."
        Dir.chdir(Rails.root) do
          `rake io_ask:install:migrations`
        end
      end

      def determine_user_class
        @user_class = options["user-class"].presence ||
                      ask("What is your user class called? [User]").presence ||
                      'User'
      end


      def determine_category_class
        @category_class = options["category-class"].presence ||
                      ask("What is your category class called? [Category]").presence ||
                      'Category'
      end


      def determine_current_user_helper
        current_user_helper = options["current-user-helper"].presence ||
                              ask("What is the current_user helper called in your app? [current_user]").presence ||
                              :current_user

        puts "Defining io_ask_user method inside ApplicationController..."

        io_ask_user_method = %Q{
  def io_ask_user
    #{current_user_helper}
  end
  helper_method :io_ask_user

}

        inject_into_file("#{Rails.root}/app/controllers/application_controller.rb",
                         io_ask_user_method,
                         :after => "ActionController::Base\n")

      end

      def add_io_ask_initializer
        path = "#{Rails.root}/config/initializers/io_ask.rb"
        # if File.exists?(path)
        #   puts "Skipping config/initializers/io_ask.rb creation, as file already exists!"
        # else
        #   puts "Adding io_ask initializer (config/initializers/io_ask.rb)..."
        #   template "initializer.rb", path
        #   require path
        # end

        puts "Adding io_ask initializer (config/initializers/io_ask.rb)..."
        template "initializer.rb", path
        require path
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end

      def seed_database
        load "#{Rails.root}/config/initializers/io_ask.rb"
        unless options["no-migrate"]
          puts "Creating default ask and topic"
          IoAsk::Engine.load_seed
        end
      end

      def mount_engine
        puts "Mounting IoAsk::Engine at \"/io_ask\" in config/routes.rb..."
        insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{
  # This line mounts IoAsk's routes at /ask by default.
  # This means, any requests to the /ask URL of your application will go to IoAsk::TopicsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as IoAsk relies on it being the default of "IoAsk"
  mount IoAsk::Engine, :at => '/ask'

}
        end
      end

      def create_assets
        create_file Rails.root + "vendor/assets/stylesheets/io_ask.css.scss" do
          %Q{
          }
        end
        create_file Rails.root + "vendor/assets/javascripts/io_ask.js.coffee" do
          %Q{
#= require jquery
          }
        end
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nDone! IoAsk has been successfully installed. Yaaaaay!

Here's what happened:\n\n}

        output += step("io_ask's migrations were copied over into db/migrate.\n")
        output += step("We created a new migration called AddIoAskAdminToTable.
   This creates a new field called \"io_ask_admin\" on your #{user_class} model's table.\n")
        output += step("A new method called `io_ask_user` was inserted into your ApplicationController.
   This lets io_ask know what the current user of your application is.\n")
        output += step("A new file was created at config/initializers/io_ask.rb
   This is where you put io_ask's configuration settings.\n")

        unless options["no-migrate"]
output += step("`rake db:migrate` was run, running all the migrations against your database.\n")
        output += step("Seed ask and topic were loaded into your database.\n")
        end
        output += step("The engine was mounted in your config/routes.rb file using this line:

   mount IoAsk::Engine, :at => \"/ask\"

   If you want to change where the ask are located, just change the \"/ask\" path at the end of this line to whatever you want.")
        output += %Q{\nAnd finally:

#{step("We told you that io_ask has been successfully installed and walked you through the steps.")}}
        unless defined?(Devise)
          output += %Q{We have detected you're not using Devise (which is OK with us, really!), so there's one extra step you'll need to do.

   You'll need to define a "sign_in_path" method for io_ask to use that points to the sign in path for your application. You can set IoAsk.sign_in_path to a String inside config/initializers/io_ask.rb to do this, or you can define it in your config/routes.rb file with a line like this:

          get '/users/sign_in', :to => "users#sign_in"

   Either way, io_ask needs one of these two things in order to work properly. Please define them!}
        end
        output += "\nIf you have any questions, comments or issues, please post them on our issues page: http://github.com/radar/IoAsk/issues.\n\n"
        output += "Thanks for using io_ask!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end

      def category_class
        @category_class
      end

      def next_migration_number
        last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
        current_migration_number = /^(\d+)_/.match(last_migration)[1]
        current_migration_number.to_i + 1
      end
    end
  end
end
