# frozen_string_literal: true

module Followability
  module Followable
    module Actions
      module Common
        def myself?(record)
          id == record.id
        end
      end
    end
  end
end
