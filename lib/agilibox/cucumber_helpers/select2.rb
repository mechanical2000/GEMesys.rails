module CapybaraSelect2
  def select2_search(id, query)
    find("##{id} + .select2-container").click
    find(".select2-search__field").set(query.to_s)
  end

  def select2(id, query, label = query)
    select2_search(id, query)
    find(".select2-results li", text: label.to_s).click
  end

  def select2_expect_have_result(id, query, label = query)
    select2_search(id, query)
    expect(page).to have_selector(".select2-results li", text: label.to_s)
  end

  def select2_expect_have_no_result(id, query, label = query)
    select2_search(id, query)
    expect(page).to have_no_selector(".select2-results li", text: label.to_s)
  end
end

World(CapybaraSelect2)
