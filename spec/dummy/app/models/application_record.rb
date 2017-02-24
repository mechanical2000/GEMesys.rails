class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Agilibox::ActiveRecordUUIDConcern
  include Agilibox::DefaultValuesConcern
  include Agilibox::ModelToS
  include Agilibox::ModelI18n
  include Agilibox::PolymorphicId
end
