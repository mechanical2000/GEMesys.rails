window.modal =
  i18n:
    loading: "Loading..."
    error: "Error."

  template: """
    <div id="modal" class="closable">
      <div id="modal-overlay"></div>

      <button id="modal-close">&times;</button>

      <div id="modal-body">
        {{content}}
      </div>
    </div>
  """

  _generateModalHTML: (content) ->
    $(modal.template.replace("{{content}}", content))

  open: (content) ->
    if modal.isOpened()
      modal._update(content)
    else
      modal._create(content)
    $(document).trigger("modal:open")

  _create: (content) ->
    $("body").addClass("modal-open")
    $("body").append(modal._generateModalHTML(content))

  _update: (content) ->
    $("#modal-body").html(content)

  close: (event) ->
    event.preventDefault() if event
    $(document).trigger("modal:before-close")
    $("body").removeClass("modal-open")
    $("#modal").remove()
    $(document).trigger("modal:close")
    return true

  isOpened: -> return $("#modal").length > 0

  isClosed: -> return $("#modal").length == 0

  isClosable: -> return $("#modal").hasClass("closable")

  autoclose: (event) ->
    event.preventDefault() if event
    modal.close() if modal.isClosable()
    return true

  # Modes : normal, nested, off, unknown
  setModalMode: (mode) ->
    mode = modal.parseModalMode(mode)
    if mode != "unknown"
      try document.querySelector("#modal").dataset.modal = mode
    return true

  parseModalMode: (mode) ->
    if String(mode) == "1"
      console.log("[data-modal=1] if deprecated, please use [data-modal=nested] or [data-modal=normal]")
      return "nested"

    if String(mode) == "0"
      console.log("[data-modal=0] if deprecated, please use [data-modal=off]")
      return "off"

    if mode == "off" || mode == "normal" || mode == "nested"
      return mode
    else
      return "unknown"

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

  _callbacks:
    links: (event) ->
      return unless modal.shouldOpenInModalForElement(this)

      event.preventDefault()
      modal.openUrl(this.href)
      modal.setModalMode(this.dataset.modal)

    forms: (event) ->
      return unless modal.shouldOpenInModalForElement(this)

      event.preventDefault()

      if String(this.method).toLowerCase() == "get"
        data = $(this).serialize()
      else
        data = new FormData(this)

      modal.openUrl(this.action, this.method, data)
      modal.setModalMode(this.dataset.modal)

    escape: (event) ->
      modal.autoclose() if event.keyCode == 27

  shouldOpenInModalForElement: (element) ->
    # ALWAYS ignore
    return false if String(element.href).indexOf("javascript:") == 0
    return false if String(element.href).indexOf("mailto:") == 0
    return false if String(element.href).indexOf("tel:") == 0
    return false if String(element.href).indexOf("sms:") == 0
    return false if String(element.target).indexOf("_") == 0
    return false if String(element.dataset.remote || "") != ""
    return false if String(element.dataset.method || "") != ""
    return false if modal.parseModalMode(element.dataset.modal) == "off"

    # True if element mode is NORMAL or NESTED
    elementMode = modal.parseModalMode(element.dataset.modal)
    return true if elementMode == "normal" || elementMode == "nested"

    # True if element is inside a NESTED modal
    if $(element).parents("#modal[data-modal=nested]").length
      return true

    # Hidden forms created by jquery_ujs for remote links inside a NESTED modal
    if $(element).parent().is("body.modal-open") && $("#modal[data-modal=nested]").length
      return true

    return false

  setup: ->
    $(document).on("keyup", modal._callbacks.escape)
    $(document).on("click", "#modal-overlay, #modal-close, .modal-autoclose", modal.autoclose)
    $(document).on("click", "a", modal._callbacks.links)
    $(document).on("submit", "form", modal._callbacks.forms)

modal.setup()
