# frozen_string_literal: true

module Followability
  module Followable
    module Actions
      module Follow
        def decline_follow_request_of(record); end

        def remove_follow_request_of(record); end

        def send_follow_request_to(record); end

        def following?(record); end

        def mutual_following_with?(record); end

        def sent_follow_request_to?(record); end
      end
    end
  end
end
