class Agilibox::MiniModelSerializer::Serialize
  attr_reader :object, :options

  def initialize(object, options = {})
    @object  = object
    @options = options
  end

  def call
    if object.is_a?(Hash)
      object.map { |k, v| [k.to_s, serialize(v)] }.to_h
    elsif object.is_a?(Enumerable)
      object.map { |e| serialize(e) }
    elsif (serializer = "#{object.class}Serializer".safe_constantize)
      serializer.call(object, options)
    else
      object.as_json
    end
  end

  def self.call(*args)
    new(*args).call
  end

  private

  def serialize(object)
    Agilibox::MiniModelSerializer::Serialize.call(object, options)
  end
end
