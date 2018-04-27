module Agilibox::FiltersHelper
  def filter_submit_button(options = {})
    options[:class] ||= "btn btn-default submit filter-submit"
    options[:type]  ||= "submit"
    options[:value] ||= "submit"

    text = options.delete(:text) || t("actions.filter")
    icon = options.delete(:icon) || :filter

    content_tag(:button, options) do
      icon(icon) + " " + text
    end
  end

  def filter_reset_button(options = {})
    options[:class] ||= "btn btn-default reset filter-reset"
    options[:type]  ||= "submit"
    options[:value] ||= "reset"

    text = options.delete(:text) || t("actions.reset")
    icon = options.delete(:icon) || :undo

    content_tag(:button, options) do
      icon(icon) + " " + text
    end
  end

  def filter_buttons
    filter_reset_button + filter_submit_button
  end

  def filters_form(options = {}, &block)
    if options.key?(:buttons)
      buttons = options.delete(:buttons)
    else
      buttons = true
    end

    options = {
      :url     => agilibox.small_data_filters_path,
      :wrapper => :inline_form,
    }.merge(options)

    html = simple_form_for(:filters, options, &block)

    if buttons
      html = html.gsub("</form>", "#{form_hidden_submit + filter_buttons}</form>").html_safe
    end

    html
  end

  def agilibox_time_periods_for_select
    {
      t("time_periods.all_time")    => "",
      t("time_periods.today")       => "today",
      t("time_periods.yesterday")   => "yesterday",
      t("time_periods.this_week")   => "this_week",
      t("time_periods.last_week")   => "last_week",
      t("time_periods.this_month")  => "this_month",
      t("time_periods.last_month")  => "last_month",
      t("time_periods.this_year")   => "this_year",
      t("time_periods.last_year")   => "last_year",
      t("time_periods.custom_date") => "custom_date",
    }
  end
end
