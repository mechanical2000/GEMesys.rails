module Agilibox::BootstrapHelper
  class << self
    attr_writer :card_classes

    def card_classes
      @card_classes ||= {
        :card   => "card",
        :header => "card-header",
        :body   => "card-body",
        :footer => "card-footer",
      }
    end
  end

  def bs_progress_bar(percentage)
    tag.div(class: "progress") do
      tag.div(class: "progress-bar", style: "width:#{percentage}%") do
        "#{percentage}%"
      end
    end
  end

  def bs_card( # rubocop:disable Metrics/ParameterLists
    header: nil,
    body: true,
    footer: nil,
    card_tag: :div,
    header_tag: :div,
    body_tag: :div,
    footer_tag: :div,
    card_class: nil,
    header_class: nil,
    body_class: nil,
    footer_class: nil,
    &block
  )
    global_classes = Agilibox::BootstrapHelper.card_classes
    card_classes   = ([global_classes[:card]]   + card_class.to_s.split).compact.sort
    header_classes = ([global_classes[:header]] + header_class.to_s.split).compact.sort
    body_classes   = ([global_classes[:body]]   + body_class.to_s.split).compact.sort
    footer_classes = ([global_classes[:footer]] + footer_class.to_s.split).compact.sort

    if header
      header_html = content_tag(header_tag, class: header_classes) { header }
    else
      header_html = "".html_safe
    end

    if body
      body_html = content_tag(body_tag, class: body_classes) { capture(&block) }
    else
      body_html = capture(&block)
    end

    if footer
      footer_html = content_tag(footer_tag, class: footer_classes) { footer }
    else
      footer_html = "".html_safe
    end

    content_tag(card_tag, class: card_classes) do
      header_html + body_html + footer_html
    end
  end
end
