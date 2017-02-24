$(document).on "click", "button.reset", ->
  form = $(this).parents("form")
  form.find("input, textarea, select").map ->
    return if String(this.type).match(/submit|hidden|button/)
    $(this).val String($(this).data("default-value") || "")
