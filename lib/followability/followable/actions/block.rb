# frozen_string_literal: true

module Followability
  module Followable
    module Actions
      module Block
        I18N_SCOPE = 'followability.errors.block'

        def block(record)
          if myself?(record)
            errors.add(:base, I18n.t('block.myself', scope: I18N_SCOPE, klass: record.class))

            return false
          end

          if blocked_by?(record)
            errors.add(:base, I18n.t('block.blocked_by', scope: I18N_SCOPE, klass: record.class))

            return false
          end

          if blocked?(record)
            errors.add(:base, I18n.t('block.already_blocked', scope: I18N_SCOPE, klass: record.class))

            return false
          end

          relation = followerable_relationships.blocked.new(followable: record,
                                                            status: Followability::Relationship.statuses[:blocked])

          if relation.save
            run_callback(self, affected: record, callback: :followable_blocked_by_me)
            run_callback(record, affected: self, callback: :followable_blocked_by_someone)

            true
          else
            errors.add(:base, relation.errors.full_messages.to_sentence)

            false
          end
        end

        def unblock(record)
          if myself?(record)
            errors.add(:base, I18n.t('unblock.myself', scope: I18N_SCOPE, klass: record.class))

            return false
          end

          unless blocked?(record)
            errors.add(:base, I18n.t(:not_blocked_for_blocking, scope: I18N_SCOPE, klass: record.class))

            return false
          end

          relation = followerable_relationships.blocked.find_by(followable: record)

          if relation.destroy
            run_callback(self, affected: record, callback: :followable_unblocked_by_me)
            run_callback(record, affected: self, callback: :followable_unblocked_by_someone)

            true
          else
            errors.add(:base, relation.errors.full_messages.to_sentence)

            false
          end
        end

        def blocked?(record)
          followerable_relationships.blocked.exists?(followable: record)
        end

        def blocked_by?(record)
          record.followerable_relationships.blocked.exists?(followable: self)
        end
      end
    end
  end
end
