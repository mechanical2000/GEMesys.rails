$(document).on "turbolinks:load", ->
  $("select.select2").map -> $(this).select2()
