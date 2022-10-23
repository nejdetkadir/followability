# frozen_string_literal: true

module Followability
  module Followable
    def followability?
      false
    end

    # rubocop:disable Metrics/MethodLength, Metrics/BlockLength
    def followability
      class_eval do
        def self.followability?
          true
        end

        has_many :followerable_relationships,
                 as: :followerable,
                 class_name: 'Followability::Relationship',
                 dependent: :destroy

        has_many :followable_relationships,
                 as: :followable,
                 class_name: 'Followability::Relationship',
                 dependent: :destroy

        has_many :followers,
                 -> { Followability::Relationship.following },
                 through: :followable_relationships,
                 source: :followerable,
                 class_name: name,
                 source_type: name

        has_many :following,
                 -> { Followability::Relationship.following },
                 through: :followerable_relationships,
                 source: :followable,
                 class_name: name,
                 source_type: name

        has_many :blocks,
                 -> { Followability::Relationship.blocked },
                 through: :followerable_relationships,
                 source: :followable,
                 class_name: name,
                 source_type: name

        has_many :blockers,
                 -> { Followability::Relationship.blocked },
                 through: :followable_relationships,
                 source: :followerable,
                 class_name: name,
                 source_type: name
      end

      include Followability::Followable::Associations
      include Followability::Followable::Callbacks
      include Followability::Followable::Actions::Common
      include Followability::Followable::Actions::Follow
      include Followability::Followable::Actions::Block
    end
    # rubocop:enable Metrics/MethodLength, Metrics/BlockLength
  end
end
