module Agilibox::PluckToHash
  extend ActiveSupport::Concern

  class_methods do
    def pluck_to_hash(*attributes)
      pluck(*attributes).map { |values| attributes.zip(values).to_h }
    end
  end # class_methods
end
