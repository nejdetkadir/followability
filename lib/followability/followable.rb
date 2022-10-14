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
      end

      include Followability::Followable::Callbacks
      include Followability::Followable::Actions::Follow
      include Followability::Followable::Actions::Block
    end
  end
end
