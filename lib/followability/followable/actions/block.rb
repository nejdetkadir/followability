# frozen_string_literal: true

module Followability
  module Followable
    module Actions
      module Block
        def block_to; end

        def unblock_to; end

        def blocked?(record); end

        def blocked_by?(record); end
      end
    end
  end
end
