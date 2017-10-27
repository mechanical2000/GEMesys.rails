module Kernel
  def engine_file(engine)
    app_file      = caller(1..1).first.split(":").first
    app_root      = ::Rails.application.root.to_s
    relative_file = app_file.sub(app_root, "")
    engine_root   = engine::Engine.root.to_s

    ::File.join(engine_root, relative_file)
  end
end
