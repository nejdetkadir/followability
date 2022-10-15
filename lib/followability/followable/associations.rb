# frozen_string_literal: true

module Followability
  module Followable
    module Associations
      def follow_requests
        followable_relationships.requested
      end

      def pending_requests
        followerable_relationships.requested
      end
    end
  end
end
