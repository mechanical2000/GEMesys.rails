class DummyModel < ApplicationRecord
  belongs_to :asso, polymorphic: true, optional: true

  polymorphic_id_for :asso

  def state
    "draft"
  end
end
