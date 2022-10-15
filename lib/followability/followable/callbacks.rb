# frozen_string_literal: true

module Followability
  module Followable
    module Callbacks
      METHOD_NAMES = %w[
        on_request_sent
        on_request_accepted
        on_request_declined
        on_request_removed
        on_followable_blocked
        on_followable_unblocked
        on_relation_changed
      ].freeze

      def run_callback(record, callback:)
        if METHOD_NAMES.exclude?(callback.to_s) || callback.eql?(:on_relation_changed) || !callback.is_a?(Symbol)
          raise ArgumentError
        end

        [callback, :on_relation_changed].each do |cb_name|
          record.send(cb_name, record, cb_name) if record.respond_to?(cb_name)
        end
      end
    end
  end
end
