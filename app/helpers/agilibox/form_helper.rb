module Agilibox::FormHelper
  include Agilibox::I18nHelper

  # Hidden submit to be the default triggered on <enter> keypress on a form
  def form_hidden_submit
    tag(:input, type: "submit", class: "hidden-submit")
  end

  def form_buttons(opts = {})
    back_url = opts[:back_url]
    back_url = url_for(:back).html_safe if back_url.nil?
    back_url = URI(back_url).path       if back_url.to_s.include?("://")

    if opts[:obj].present?
      if opts[:obj].new_record?
        submit_action = :create
      else
        submit_action = :update
      end
    else
      submit_action = :save
    end

    content_tag("div", class: "actions form-actions") do
      submit = content_tag(:button, type: :submit, class: "btn btn-sm btn-success form-submit") do
        content_tag(:span, class: "fa fa-save") {} + " " + ta(submit_action)
      end

      cancel = content_tag("a", href: back_url, class: "btn btn-primary btn-sm form-cancel") do
        content_tag(:span, class: "fa fa-times") {} + " " + ta(:cancel)
      end

      cancel = "" if back_url == false

      submit + cancel
    end
  end

  def horizontal_form_for(obj, opts = {}, &block)
    opts = {
      :wrapper => "horizontal_form",
      :html => {
        :class => "form-horizontal",
      },
    }.deep_merge(opts)

    simple_form_for(obj, opts, &block)
  end

  def search_form(opts = {})
    action = opts.delete(:action) || request.fullpath

    render "agilibox/search/form", action: action
  end

  def checkboxes_dropdown(f, input, collection, label = t("actions.select"))
    render("agilibox/forms/checkboxes_dropdown",
      :f          => f,
      :input      => input,
      :collection => collection,
      :label      => label,
    )
  end
end
