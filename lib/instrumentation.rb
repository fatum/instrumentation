require "instrumentation/version"

require 'active_support/concern'
require 'active_support/core_ext/class/attribute'
require 'active_support/notifications'

require 'instrumentation/active_record' if defined?(ActiveRecord)

module Instrumentation
  extend ActiveSupport::Concern

  included do |base|
    base.class_attribute :instrumentation_channel

    if defined?(::ActiveRecord::Base) && self.ancestors.include?(::ActiveRecord::Base)
      include ActiveRecord
    end

    def self.instrument(channel, payload, &block)
      ActiveSupport::Notifications.instrument(channel, payload, &block)
    end

    def self.say(msg)
      Rails.logger.info "[#{self.instrumentation_channel.to_s}] #{self.name} #{msg}"
    end

    def self.subscribe_to(channel)
      self.instrumentation_channel = channel

      ActiveSupport::Notifications.subscribe(channel, self)
    end

    def say(msg)
      self.class.say(msg)
    end

    def instrument(channel, payload, &block)
      self.class.instrument(channel, payload, &block)
    end
  end
end
