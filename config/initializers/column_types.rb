require "active_record/connection_adapters/postgresql_adapter"

module ActiveRecord
  module ConnectionAdapters
    # https://medium.com/@frodsan/activerecord-better-native-types-mappings-for-postgresql-b5391d14ea68
    class PostgreSQLAdapter
      NATIVE_DATABASE_TYPES.merge!(
        primary_key: "uuid primary key default uuid_generate_v1mc()",
        datetime:  { name: "timestamptz" },
        timestamp: { name: "timestamptz" },
        string: { name: "text" }
      )
    end

    # https://stackoverflow.com/questions/15561236/rails-ruby-how-do-i-override-the-migration-method-timestamps#15608158
    class TableDefinition
      def timestamps(*args)
        options = args.extract_options!
        options[:default] = -> { 'CURRENT_TIMESTAMP' }
        options[:null] = false
        column(:created_at, :datetime, options)
        column(:updated_at, :datetime, options)
      end
    end
 end
end

class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::TableDefinition

end
