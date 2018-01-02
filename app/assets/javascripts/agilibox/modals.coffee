window.modal =
  i18n:
    loading: "Loading..."
    error: "Error."

  template: """
    <div id='modal' class='closable'>
      <div id='modal-overlay'></div>

      <button id='modal-close'>×</button>

      <div id='modal-body'>
        {{content}}
      </div>
    </div>
  """

  _generateModalHTML: (content) ->
    $(modal.template.replace("{{content}}", content))

  open: (content) ->
    if modal.is_opened()
      modal._update(content)
    else
      modal._create(content)
    $(document).trigger("modal:open")

  _create: (content) ->
    $("body").addClass("modal-open")
    $("body").append(modal._generateModalHTML(content))

  _update: (content) ->
    $("#modal-body").html(content)

  close: ->
    $("body").removeClass("modal-open")
    $("#modal").remove()
    $(document).trigger("modal:close")
    return false

  is_opened: ->
    return $("#modal").length > 0

  is_closed: ->
    return $("#modal").length == 0

  is_closable: ->
    return $("#modal").hasClass("closable")

  autoclose: ->
    modal.close() if modal.is_closable()
    return false

  set_closable: ->
    $("#modal").addClass("closable")

  set_unclosable: ->
    $("#modal").removeClass("closable")

  _set_closable_for_element: (element) ->
    return modal.set_closable()   if $(element).is("[data-modal-closable=1]")
    return modal.set_unclosable() if $(element).is("[data-modal-closable=0]")

  openUrl: (url, type = "GET", data = {}) ->
    modal.open(modal.i18n.loading)

    $.ajax
      url: url
      type: type
      data: data
      dataType: "html"
      processData: false
      contentType: false

      success: (data, textStatus, xhr) ->
        contentType = xhr.getResponseHeader("Content-Type")

        if contentType.match(/html/)
          modal.open(data)
          $(document).trigger("modal:load")
        else if contentType.match(/javascript/)
          eval(data)
        else
          console.log("Invalid Content-Type " + contentType)

      error: ->
        modal.open(modal.i18n.error)
        modal.set_closable()

  _callbacks:
    links: ->
      modal.openUrl(this.href)
      modal._set_closable_for_element(this)
      return false

    forms: ->
      if String(this.method).toLowerCase() == "get"
        data = $(this).serialize()
      else
        data = new FormData(this)
      modal.openUrl(this.action, this.method, data)
      modal._set_closable_for_element(this)
      return false

    escape: (event) ->
      modal.autoclose() if event.keyCode == 27
      return true

  setup: ->
    $(document).on("keyup", modal._callbacks.escape)
    $(document).on("click", "#modal-overlay, #modal-close", modal.autoclose)
    $(document).on("click", "a[data-modal=1], #modal a[href]:not([data-modal=0]):not([data-remote]):not([data-method])", modal._callbacks.links)
    $(document).on("submit", "form[data-modal=1], #modal form:not([data-modal=0]):not([data-remote])", modal._callbacks.forms)
    # Forms created by jquery_ujs for remote links
    $(document).on("submit", "body.modal-open > form", modal._callbacks.forms)

modal.setup()
