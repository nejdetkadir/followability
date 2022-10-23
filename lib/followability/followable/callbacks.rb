# frozen_string_literal: true

module Followability
  module Followable
    module Callbacks
      METHOD_NAMES = %i[
        follow_request_sent_to_someone
        follow_request_sent_to_me
        follow_request_accepted_by_me
        follow_request_accepted_by_someone
        follow_request_declined_by_me
        follow_request_declined_by_someone
        follow_request_removed_by_me
        follow_request_removed_by_someone
        followable_blocked_by_me
        followable_blocked_by_someone
        followable_unblocked_by_me
        followable_unblocked_by_someone
        unfollowed_by_me
        unfollowed_by_someone
        followability_triggered
      ].freeze

      def run_callback(record, callback:, affected:)
        raise ArgumentError if METHOD_NAMES.exclude?(callback) || callback.eql?(:followability_triggered)

        [callback, :followability_triggered].each do |cb_name|
          record.send(cb_name, affected, cb_name) if record.respond_to?(cb_name)
        end
      end
    end
  end
end
