class DummyModel < ApplicationRecord
  belongs_to :asso, polymorphic: true, required: false

  polymorphic_id_for :asso

  def state
    "draft"
  end
end
