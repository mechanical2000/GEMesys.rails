$(document).on "click", ".checkboxes-dropdown .dropdown-menu", (e) ->
  e.stopPropagation()

$(document).on "change", ".checkboxes-dropdown [type=checkbox]", ->
  $dropdown = $(this).parents(".checkboxes-dropdown")
  $dropdown.find(".number").html $dropdown.find(":checked").length

$(document).on "turbolinks:load", ->
  $(".checkboxes-dropdown [type=checkbox]").change()
