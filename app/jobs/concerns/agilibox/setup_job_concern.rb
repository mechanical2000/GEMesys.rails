module Agilibox::SetupJobConcern
  extend ActiveSupport::Concern

  def perform(*args)
    setup(*args)
    call
  end

  def call
    raise NotImplementedError
  end

  class_methods do
    def setup_with(*attrs)
      attr_reader(*attrs)

      define_method(:setup) do |*args|
        if attrs.length != args.length
          message = "wrong number of arguments (given #{args.length}, expected #{attrs.length})"
          raise ArgumentError, message
        end

        attrs.length.times do |i|
          instance_variable_set("@#{attrs[i]}", args[i])
        end
      end
    end

    private :setup_with

    def setup(*args)
      new.tap { |instance| instance.setup(*args) }
    end
  end # class_methods
end
