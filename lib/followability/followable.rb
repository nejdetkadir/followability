# frozen_string_literal: true

module Followability
  module Followable
    def followability?
      false
    end

    def followability
      class_eval do
        def self.followability?
          true
        end

        has_many :followability_relationships,
                 as: :followerable,
                 class_name: 'Followability::Relationship',
                 dependent: :destroy
      end

      include Followability::Followable::Callbacks
      include Followability::Followable::Actions::Common
      include Followability::Followable::Actions::Follow
      include Followability::Followable::Actions::Block
    end
  end
end
