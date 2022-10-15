# frozen_string_literal: true

module Followability
  module Followable
    module Actions
      module Block
        I18N_SCOPE = 'followability.errors'

        def block_to(record)
          if blocked?(record)
            errors.add(:base, I18n.t(:already_blocked, scope: I18N_SCOPE, klass: record.class))

            return false
          end

          relation = followability_relationships.blocked.new(followable: record,
                                                             status: Followability::Relationship.statuses[:blocked])

          if relation.save
            run_callback(self, callback: :on_followable_blocked)

            true
          else
            errors.add(:base, relation.errors.full_messages.to_sentence)

            false
          end
        end

        def unblock_to(record)
          unless blocked?(record)
            errors.add(:base, I18n.t(:not_blocked_for_blocking, scope: I18N_SCOPE, klass: record.class))

            return false
          end

          relation = followability_relationships.blocked.find_by(followable: record)

          if relation.destroy
            run_callback(self, callback: :on_followable_unblocked)

            true
          else
            errors.add(:base, relation.errors.full_messages.to_sentence)

            false
          end
        end

        def blocked?(record)
          followability_relationships.blocked.exists?(followable: record)
        end

        def blocked_by?(record)
          record.followability_relationships.blocked.exists?(followable: self)
        end
      end
    end
  end
end
