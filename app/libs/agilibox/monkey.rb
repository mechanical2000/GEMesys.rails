module Agilibox::Monkey
  extend ActiveSupport::Concern

  class_methods do
    def prepend_instances(&block)
      m = Module.new(&block)
      send(:prepend, m)
    end

    def prepend_class(&block)
      m = Module.new(&block)
      singleton_class.send(:prepend, m)
    end

    def prepend_instance_method(name, &block)
      check_instance_method_exist!(name)

      m = Module.new
      m.send(:define_method, name, &block)
      send(:prepend, m)
    end

    def prepend_class_method(name, &block)
      check_class_method_exist!(name)

      m = Module.new
      m.send(:define_method, name, &block)
      singleton_class.send(:prepend, m)
    end

    def check_instance_method_exist!(name)
      raise "instance method `#{name}` does not exist" unless instance_methods.include?(name)
    end

    def check_class_method_exist!(name)
      raise "class method `#{name}` does not exist" unless methods.include?(name)
    end
  end
end
