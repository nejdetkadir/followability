# frozen_string_literal: true

require 'rails/generators'

module Followability
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def create_migration
        invoke 'migration', migration_args
        copy_file locale_source, locale_destination
      end

      def fields_command
        %w[
          followerable:belongs_to{polymorphic}
          followable:belongs_to{polymorphic}
          status:integer
        ]
      end

      def locale_source
        File.expand_path('../../../config/locales/en.yml', __dir__)
      end

      def locale_destination
        'config/locales/followability.en.yml'
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
