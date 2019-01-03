Capybara.add_selector(:agilibox_clickable) do
  xpath do |locator, **options|
    self.class.all
      .values_at(:link, :button, :label)
      .map { |selector| instance_exec(locator, options, &selector.xpath) }
      .reduce(:union)
  end
end
