module Agilibox::ButtonHelper
  def bs_button(url, options = {})
    action = options.delete(:action)
    icon   = options.delete(:icon)
    text   = options.delete(:text) || t("actions.#{action}")
    title  = options.delete(:title) || text

    text   = %(#{icon icon} <span class="text">#{text}</span>).html_safe

    options = {
      :class => "btn btn-xs btn-default link_#{action}",
      :title => title,
    }.deep_merge(options)

    if (confirm = options.delete(:confirm))
      confirm = t("actions.confirm") if confirm == true

      options.deep_merge!(
        :data => {
          :confirm => confirm,
        },
      )
    end

    link_to(text, url, options)
  end

  def print_button(options = {})
    options = {
      :icon    => :print,
      :action  => :print,
      :class   => "btn btn-xs btn-default",
      :onclick => "print(); return false;",
    }.merge(options)

    bs_button("#", options)
  end

  def create_button(url, options = {})
    options = {
      :icon   => :plus,
      :action => :create,
      :class  =>"btn btn-xs btn-success link_create",
    }.merge(options)

    bs_button(url, options)
  end

  def read_button(url, options = {})
    options = {
      :icon   => :info_circle,
      :action => :read,
    }.merge(options)

    bs_button(url, options)
  end

  def download_button(url, options = {})
    options = {
      :icon     => :cloud_download_alt,
      :action   => :download,
      :download => url,
    }.merge(options)

    bs_button(url, options)
  end

  def export_button(url, options = {})
    ext = url.split(".").last

    if ext.length <= 4
      action = :"export_#{ext}"
    else
      action = :export
    end

    options = {
      :icon     => :download,
      :action   => action,
      :download => url,
    }.merge(options)

    bs_button(url, options)
  end

  def import_button(url, options = {})
    options = {
      :icon     => :upload,
      :action   => :import,
    }.merge(options)

    bs_button(url, options)
  end

  def update_button(url, options = {})
    options = {
      :icon   => :pencil_alt,
      :action => :update,
    }.merge(options)

    bs_button(url, options)
  end

  def delete_button(url, options = {})
    options = {
      :icon    => :trash,
      :action  => :delete,
      :class   => "btn btn-xs btn-danger link_delete",
      :confirm => true,
      :method  => :delete,
    }.merge(options)

    bs_button(url, options)
  end

  def copy_button(url, options = {})
    options = {
      :icon    => :copy,
      :action  => :copy,
    }.merge(options)

    bs_button(url, options)
  end

  def complete_button(url, options = {})
    options = {
      :icon    => :check,
      :action  => :complete,
      :class   => "btn btn-xs btn-success link_complete",
      :confirm => true,
      :method  => :patch,
    }.merge(options)

    bs_button(url, options)
  end

  def snooze_button(url, options = {})
    options = {
      :icon    => :clock,
      :action  => :snooze,
      :confirm => true,
      :method  => :patch,
    }.merge(options)

    bs_button(url, options)
  end

  def lock_button(url, options = {})
    options = {
      :icon    => :lock,
      :action  => :lock,
      :confirm => true,
      :method  => :patch,
    }.merge(options)

    bs_button(url, options)
  end

  def unlock_button(url, options = {})
    options = {
      :icon    => :unlock,
      :action  => :unlock,
      :confirm => true,
      :method  => :patch,
    }.merge(options)

    bs_button(url, options)
  end
end
