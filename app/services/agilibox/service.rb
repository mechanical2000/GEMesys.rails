class Agilibox::Service
  include Agilibox::InitializeWith

  def self.call(*args)
    new(*args).call
  end

  def call(*)
    raise NotImplementedError
  end
end
