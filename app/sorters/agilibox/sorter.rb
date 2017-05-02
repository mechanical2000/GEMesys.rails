class Agilibox::Sorter
  include Agilibox::SortingHelper

  attr_reader :collection, :sort_param, :column, :direction

  def initialize(collection, sort_param)
    @collection         = collection
    @sort_param         = sort_param
    @column, @direction = sortable_column_order(sort_param.to_s)
  end

  def sort
    raise NotImplementedError
  end

  def call
    # Don't replace by `collection.reorder(sort)`
    # #sort can change #collection and must be called before #collection
    order = sort
    collection.reorder(order)
  end

  def self.call(*args)
    new(*args).call
  end
end
