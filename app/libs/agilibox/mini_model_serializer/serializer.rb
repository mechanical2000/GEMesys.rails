class Agilibox::MiniModelSerializer::Serializer < Agilibox::MiniModelSerializer::Serialize
  def attributes
    raise NotImplementedError
  end

  def call
    serialize(attributes.index_with { |k| send(k) })
  end

  private

  def method_missing(m, *args)
    if respond_to_missing?(m)
      object.send(m, *args)
    else
      super
    end
  end

  def respond_to_missing?(m, *)
    object.respond_to?(m, true)
  end
end
