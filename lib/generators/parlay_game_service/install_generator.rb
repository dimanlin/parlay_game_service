module ParlayGameService
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      desc "init configuration for parlay_game_service"
      def create_initializer_file
        template 'parlay_game_service_config.rb', 'config/initializers/parlay_game_service_config.rb'
      end
    end
  end
end
