module Agilibox::PluckDistinct
  extend ActiveSupport::Concern

  class_methods do
    def pluck_distinct(column)
      all
        .reorder(column)
        .select(column)
        .distinct
        .pluck(column)
    end
  end # class_methods
end
