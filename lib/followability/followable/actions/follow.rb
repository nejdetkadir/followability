# frozen_string_literal: true

module Followability
  module Followable
    module Actions
      module Follow
        I18N_SCOPE = 'followability.errors.follow'

        def decline_follow_request_of(record)
          relation = follow_requests.find_by(followerable_id: record.id, followerable_type: record.class.name)

          if relation.blank?
            errors.add(:base,
                       I18n.t('decline_follow_request_of.empty_relation', scope: I18N_SCOPE, klass: record.class.name))

            false
          elsif relation.destroy
            run_callback(self, callback: :follow_request_declined_by_me)
            run_callback(record, callback: :follow_request_declined_by_someone)

            true
          else
            errors.add(:base, relation.errors.full_messages.to_sentence)

            false
          end
        end

        def accept_follow_request_of(record)
          relation = follow_requests.find_by(followerable_id: record.id, followerable_type: record.class.name)

          if relation.blank?
            errors.add(:base,
                       I18n.t('accept_follow_request_of.empty_relation', scope: I18N_SCOPE, klass: record.class.name))

            false
          elsif relation.update(status: Followability::Relationship.statuses[:following])
            run_callback(record, callback: :follow_request_accepted_by_someone)
            run_callback(self, callback: :follow_request_accepted_by_me)

            true
          else
            errors.add(:base, relation.errors.full_messages.to_sentence)

            false
          end
        end

        def remove_follow_request_for(record)
          relation = pending_requests.find_by(followable_id: record.id, followable_type: record.class.name)

          if relation.blank?
            errors.add(:base,
                       I18n.t('remove_follow_request_for.empty_relation', scope: I18N_SCOPE, klass: record.class.name))

            false
          elsif relation.destroy
            run_callback(self, callback: :follow_request_removed_by_me)
            run_callback(record, callback: :follow_request_removed_by_someone)

            true
          else
            errors.add(:base, relation.errors.full_messages.to_sentence)

            false
          end
        end

        # rubocop:disable Metrics/AbcSize
        def send_follow_request_to(record)
          if blocked_by?(record)
            errors.add(:base, I18n.t('send_follow_request_to.blocked_by', scope: I18N_SCOPE, klass: record.class.name))

            return false
          end

          if following?(record)
            errors.add(:base,
                       I18n.t('send_follow_request_to.following', scope: I18N_SCOPE,
                                                                  klass: pluralize(record.class.name)))

            return false
          end

          if sent_follow_request_to?(record)
            errors.add(:base,
                       I18n.t('send_follow_request_to.already_sent', scope: I18N_SCOPE, klass: record.class.name))

            return false
          end

          if blocked?(record)
            errors.add(:base, I18n.t('send_follow_request_to.blocked', scope: I18N_SCOPE, klass: record.class.name))

            return false
          end

          relation = pending_requests.new(followable: record,
                                          status: Followability::Relationship.statuses[:requested])

          if relation.save
            run_callback(self, callback: :follow_request_sent_to_someone)
            run_callback(record, callback: :follow_request_sent_to_me)

            true
          else
            errors.add(:base, relation.errors.full_messages.to_sentence)

            false
          end
        end
        # rubocop:enable Metrics/AbcSize

        def following?(record)
          following.exists?(id: record.id)
        end

        def mutual_following_with?(record)
          following.exists?(id: record.id) && followers.exists?(id: record.id)
        end

        def sent_follow_request_to?(record)
          record.follow_requests.exists?(followerable_id: id, followerable_type: self.class.name)
        end
      end
    end
  end
end
