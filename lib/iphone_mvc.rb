require 'active_support' 

module IphoneMvc
  ##
  # This method return the correct location of mvc-gen bin or
  # exec it using Kernel#system with the given args
  #
  def self.bin_gen(*args)
    @_mvc_gen_bin ||= [IphoneMvc.ruby_command, File.expand_path("../bin/mvc-gen", __FILE__)]
    args.empty? ? @_mvc_gen_bin : system(args.unshift(@_mvc_gen_bin).join(" "))
  end

  ##
  # This module it's used for register generators
  #
  module Generators

    DEV_PATH = File.expand_path("../../", File.dirname(__FILE__))

    class << self

      ##
      # Here we store our generators paths
      #
      def load_paths
        @_files ||= []
      end

      ##
      # Return a ordered list of task with their class
      #
      def mappings
        @_mappings ||= ActiveSupport::OrderedHash.new
      end

      ##
      # Gloabl add a new generator class
      #
      def add_generator(name, klass)
        mappings[name] = klass
      end
    end
  end # Generators
end # IphoneMvc

##
# We add our generators to IphoneMvc::Genererator
#
IphoneMvc::Generators.load_paths << Dir[File.dirname(__FILE__) + '/iphone_mvc/generators/app.rb']
