module Agilibox::TimestampHelpers
  extend ActiveSupport::Concern

  class_methods do
    def first_created
      reorder(:created_at, :id).first
    end

    def last_created
      reorder(:created_at, :id).last
    end

    def last_updated
      reorder(:updated_at, :id).last
    end
  end
end
