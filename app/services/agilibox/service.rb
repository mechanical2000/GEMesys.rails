class Agilibox::Service
  include Agilibox::InitializeWith

  if RUBY_VERSION >= "2.7.0"
    def self.call(*args, **kwargs)
      new(*args, **kwargs).call
    end
  else
    def self.call(*args)
      new(*args).call
    end
  end

  def call(*)
    raise NotImplementedError
  end
end
