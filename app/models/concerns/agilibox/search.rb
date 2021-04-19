module Agilibox::Search
  extend ActiveSupport::Concern

  class_methods do
    def default_search_fields
      columns
        .select { |column| column.type.in?([:string, :text]) }
        .map    { |column| "#{table_name}.#{column.name}" }
    end # def default_search_fields

    def search(q, *fields)
      words  = q.to_s.parameterize.split("-")
      fields = default_search_fields if fields.empty?

      return all if words.empty?

      sql_query = words.map.with_index { |_word, index|
        fields.map { |field|
          "(UNACCENT(CAST(#{field} AS TEXT)) ILIKE :w#{index})"
        }.join(" OR ")
      }.map { |e| "(#{e})" }.join(" AND ")

      sql_params = words.map.with_index { |word, index| ["w#{index}".to_sym, "%#{word}%"] }.to_h

      where(sql_query, sql_params)
    end # def search
  end # class_methods
end # class Agilibox::Search
