class Agilibox::CollectionUpdate < Agilibox::Service
  initialize_with :scope, :params_array

  def call
    update # rubocop:disable Rails/SaveBang
  end

  def update!
    ApplicationRecord.transaction do
      params_array.each do |object_param|
        if object_param[:id].present?
          object = scope.find(object_param[:id])
        else
          object = scope.new
        end

        if object_param.delete(:_destroy).to_i == 1
          object.destroy!
        else
          object.update!(object_param)
        end
      end
    end
    true
  end

  def update
    update!
  rescue ActiveRecord::RecordInvalid
    false
  end
end
