module Agilibox::ActiveRecordUUIDConcern
  extend ActiveSupport::Concern

  private

  def assign_default_uuid
    if id.nil? && self.class.columns_hash["id"].type == :uuid
      self.id = ::Agilibox::SortableUUIDGenerator.generate
    end
  end

  included do
    before_save :assign_default_uuid
  end
end
