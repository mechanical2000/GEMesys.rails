$(document).on "submit", "form", ->
  return if this.method.toUpperCase() == "GET"
  return if $(this).find("[name=form_url]").length > 0

  input       = document.createElement("input")
  input.type  = "hidden"
  input.name  = "form_url"
  input.value = location.href
  $(this).append(input)
