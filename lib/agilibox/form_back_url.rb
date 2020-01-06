module Agilibox::FormBackUrl
  def back_url_tag
    tag(:input,
      :type  => "hidden",
      :name  => "back_url",
      :value => (params[:back_url].presence || request.referer),
    )
  end

  def form_tag_with_body(html_options, content)
    output = form_tag_html(html_options)
    output.safe_concat(back_url_tag)
    output << content
    output.safe_concat("</form>")
  end
end

ActionView::Helpers::FormTagHelper.prepend(Agilibox::FormBackUrl)
