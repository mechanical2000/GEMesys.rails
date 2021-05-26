module Agilibox::PaginationHelper
  class << self
    attr_writer :theme

    def theme
      @theme ||= "twitter-bootstrap-3"
    end
  end

  def paginate(objects, options = {})
    options = {theme: Agilibox::PaginationHelper.theme}.merge(options)
    super(objects, **options).gsub(/>(\s+)</, "><").html_safe
  end

  def pagination_infos(collection)
    tag.p(class: "pagination-infos") { page_entries_info(collection) }
  end

  def pagination_and_infos(collection)
    paginate(collection) + pagination_infos(collection)
  end
end
