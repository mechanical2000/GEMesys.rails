require "rails_helper"

describe Agilibox::Monkey do
  let(:the_class) {
    Class.new do
      include Agilibox::Monkey

      def my_instance_method
        "my_instance_method"
      end

      def self.my_class_method
        "my_class_method"
      end
    end
  }

  describe "#prepend_xxx" do
    it "should work with instance" do
      the_class.prepend_instances do
        def my_instance_method
          super + "_prepended"
        end
      end

      expect(the_class.new.my_instance_method).to eq "my_instance_method_prepended"
    end

    it "should work with class" do
      the_class.prepend_class do
        def my_class_method
          super + "_prepended"
        end
      end

      expect(the_class.my_class_method).to eq "my_class_method_prepended"
    end
  end # describe "#prepend_xxx"

  describe "#prepend_xxx_method" do
    it "should work with instance methods" do
      expect(the_class).to receive(:check_instance_method_exist!).with(:my_instance_method)

      the_class.prepend_instance_method(:my_instance_method) do
        super() + "_prepended"
      end

      expect(the_class.new.my_instance_method).to eq "my_instance_method_prepended"
    end

    it "should work with class methods" do
      expect(the_class).to receive(:check_class_method_exist!).with(:my_class_method)

      the_class.prepend_class_method(:my_class_method) do
        super() + "_prepended"
      end

      expect(the_class.my_class_method).to eq "my_class_method_prepended"
    end
  end # describe "#prepend_xxx_method"

  describe "#check_xxx_method_exist!" do
    it "should be ok if instance method exists" do
      the_class.check_instance_method_exist!(:my_instance_method)
    end

    it "should be ok if class method exists" do
      the_class.check_class_method_exist!(:my_class_method)
    end

    it "should raise if instance method does not exist" do
      expect {
        the_class.check_instance_method_exist!(:invalid_instance_method)
      }.to raise_error(RuntimeError, "instance method `invalid_instance_method` does not exist")
    end

    it "should raise if class method does not exist" do
      expect {
        the_class.check_class_method_exist!(:invalid_class_method)
      }.to raise_error(RuntimeError, "class method `invalid_class_method` does not exist")
    end
  end # describe "#check_xxx_method_exist!"
end
