module Agilibox::ActiveRecordUUIDConcern
  extend ActiveSupport::Concern

  private

  def assign_default_uuid
    unless self.class.columns_hash["id"].type == :uuid
      raise "invalid id type, please change to uuid"
    end

    self.id ||= ::Agilibox::SortableUUIDGenerator.call
  end

  included do
    before_save :assign_default_uuid
  end
end
