# frozen_string_literal: true

require_relative 'followability/version'
require 'active_support'
require 'active_record'
require 'active_model'

module Followability
  extend ActiveSupport::Autoload

  require_relative 'followability/followable/associations'
  require_relative 'followability/followable/callbacks'
  require_relative 'followability/followable/actions/common'
  require_relative 'followability/followable/actions/follow'
  require_relative 'followability/followable/actions/block'
  require_relative 'followability/followable'
  require_relative 'followability/relationship'
  require_relative 'followability/generators/install_generator'
end

ActiveSupport.on_load(:active_record) do
  extend Followability::Followable
end
