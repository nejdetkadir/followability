# frozen_string_literal: true

module Followability
  class Relationship < ActiveRecord::Base
    STATUSES = %i[requested declined removed blocked following].freeze

    enum status: STATUSES

    validates :status, presence: true

    belongs_to :followerable, polymorphic: true, optional: false
    belongs_to :followable, polymorphic: true, optional: false
  end
end
