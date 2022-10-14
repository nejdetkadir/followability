# frozen_string_literal: true

require 'rails/generators'

module Followability
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def create_migration
        invoke 'migration', migration_args
      end

      def fields_command
        %w[
          followerable:belongs_to{polymorphic}
          followable:belongs_to{polymorphic}
          status:integer
        ]
      end

      def migration_name
        'CreateFollowabilityRelationships'
      end

      def migration_args
        [migration_name].concat(fields_command)
      end
    end
  end
end
