module Agilibox::BootstrapHelper
  def bs_progress_bar(percentage)
    content_tag(:div, class: "progress") do
      content_tag(:div, class: "progress-bar", style: "width:#{percentage}%") do
        "#{percentage}%"
      end
    end
  end
end
