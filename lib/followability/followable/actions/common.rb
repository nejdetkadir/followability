# frozen_string_literal: true

module Followability
  module Followable
    module Actions
      module Common
        def related_with_as_followerable?(record)
          followerable_relationships.exists?(followable: record)
        end

        def related_with_as_followable?(record)
          followable_relationships.exists?(followerable: record)
        end

        def related?(record)
          related_with_as_followerable?(record) || related_with_as_followable?(record)
        end

        def myself?(record)
          id == record.id
        end
      end
    end
  end
end
