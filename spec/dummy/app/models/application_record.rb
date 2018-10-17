class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Agilibox::ActiveRecordUUIDConcern
  include Agilibox::DefaultValuesConcern
  include Agilibox::ModelI18n
  include Agilibox::ModelToS
  include Agilibox::PluckToHash
  include Agilibox::PolymorphicId
  include Agilibox::Search
  include Agilibox::TimestampHelpers
end
