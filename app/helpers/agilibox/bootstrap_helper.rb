module Agilibox::BootstrapHelper
  def icon(id)
    id = id.to_s.tr("_", "-")
    content_tag(:span, class: "icon fa fa-#{id}") {}
  end
end
