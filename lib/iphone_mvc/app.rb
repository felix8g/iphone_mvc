module IphoneMvc
  module Generators

    class App < Thor::Group

      # Add this generator to our mvc-gen
      IphoneMvc::Generators.add_generator(:app, self)

      # Define the source template root
      def self.source_root; File.expand_path(File.dirname(__FILE__)); end
      def self.banner; "mvc-gen project [name]"; end

      # Include related modules
      include Thor::Actions
      include IphoneMvc::Generators::Actions

      desc "Description:\n\n\tmvc-gen app generates a new PureMvc application for iphone"

      argument :name, :desc => "The name of your puremvc application"

      class_option :root, :desc => "The root destination", :aliases => '-r', :default => ".", :type => :string
      class_option :destroy, :aliases => '-d', :default => false,   :type    => :boolean

      # Show help if no argv given
      require_arguments!

      def create_app
        self.destination_root = options[:root]
        @class_name = name.gsub(/\W/, "_").underscore.classify
        if in_app_root?
          directory("Classes/", destination_root(name))

          return if self.behavior == :revoke
          say (<<-TEXT).gsub(/ {10}/,'')

          =================================================================
          Your #{@class_name} application has been generated.
          =================================================================

          TEXT
        else
          say "You are not at the root of a iPhone application!" and exit unless in_app_root?
        end
      end
    end # App
  end # Generators
end # IphoneMvc