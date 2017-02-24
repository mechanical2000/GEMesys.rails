$(document).on "turbolinks:load", ->
  $("select").map ->
    select = $(this)
    form   = select.parents("form")

    return if select.find("[value=custom_date]").length == 0

    select.change ->
      if select.val() == "custom_date"
        form.find(".form-group[class*=date_begin], .form-group[class*=date_end]").show()
      else
        form.find("input[id*=date_begin], input[id*=date_end]").val("")
        form.find(".form-group[class*=date_begin], .form-group[class*=date_end]").hide()

    select.change()
