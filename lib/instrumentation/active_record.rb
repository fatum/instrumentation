module Instrumentation
  module ActiveRecord
    extend ActiveSupport::Concern

    included do |base|
      base.class_attribute :instrument_to

      after_commit :sync_update, on: :update
      after_commit :sync_create, on: :create
      after_commit :sync_destroy, on: :destroy

      def self.instrument_to(channel)
        self.instrument_to = channel
      end

      def sync_update
        if self.instrument_to
          instrument self.instrument_to, action: :update, record: self
        end
      end

      def sync_create
        if self.instrument_to
          instrument self.instrument_to, action: :create, record: self
        end
      end

      def sync_destroy
        if self.instrument_to
          instrument self.instrument_to, action: :destroy, record: self
        end
      end
    end
  end
end
