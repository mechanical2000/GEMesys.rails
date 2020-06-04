module Agilibox::SortingHelper
  def sortable_column(name, column, options = {})
    unless column.is_a?(Symbol)
      raise ArgumentError, "invalid column, please use symbol"
    end

    current_column, current_direction = sortable_column_order

    if current_column == column
      if current_direction == :asc
        name           = "#{name} ↓"
        new_sort_param = "-#{column}"
      end

      if current_direction == :desc
        name           = "#{name} ↑"
        new_sort_param = column
      end

      klass = "sort #{current_direction}"
    else
      new_sort_param = column
      klass          = "sort"
    end

    unless (url_params = options.delete(:url_params))
      url_params = (params.try(:permit!) || params).to_h.symbolize_keys
    end
    url_params[:sort] = new_sort_param

    html_options = {class: klass}.merge(options)

    link_to(name, url_params, html_options)
  end

  def sortable_column_order(sort_param = params[:sort])
    sort_param = sort_param.to_s

    if sort_param.present?
      if sort_param.start_with?("-")
        column     = sort_param[1..].to_sym
        direction  = :desc
      else
        column     = sort_param.to_sym
        direction  = :asc
      end
    end

    if block_given?
      yield(column, direction)
    else
      [column, direction]
    end
  end
end
