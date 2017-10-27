module Agilibox::Search
  extend ActiveSupport::Concern

  class_methods do
    def default_search_fields
      columns.map do |column|
        "#{table_name}.#{column.name}"
      end
    end # def default_search_fields

    def search(q, *fields)
      words  = q.to_s.parameterize.split("-")
      fields = default_search_fields if fields.empty?

      sql_query = words.map.with_index { |_word, index|
        fields.map { |field|
          "(UNACCENT(CAST(#{field} AS TEXT)) ILIKE :w#{index})"
        }.join(" OR ")
      }.map { |e| "(#{e})" }.join(" AND ")

      sql_params_a = words.map.with_index do |word, index|
        ["w#{index}".to_sym, "%#{word}%"]
      end

      sql_params_h = Hash[sql_params_a]

      where(sql_query, sql_params_h)
    end # def search
  end # class_methods
end # class Agilibox::Search
