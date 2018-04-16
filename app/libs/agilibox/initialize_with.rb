module Agilibox::InitializeWith
  extend ActiveSupport::Concern

  class_methods do
    def initialize_with(*attrs)
      attr_reader(*attrs)

      define_method(:initialize) do |*args|
        if attrs.length != args.length
          message = "wrong number of arguments (given #{args.length}, expected #{attrs.length})"
          raise ArgumentError, message
        end

        attrs.length.times do |i|
          instance_variable_set("@#{attrs[i]}", args[i])
        end
      end
    end
  end # class_methods
end
