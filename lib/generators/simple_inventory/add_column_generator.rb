require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module SimpleInventory

  class AddColumnGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    argument :table_name, type: 'string'
    source_root File.expand_path('../../templates', __FILE__)
    desc 'Generates migration for specified model to add amount column.'

    def self.next_migration_number(path)
      ActiveRecord::Generators::Base.next_migration_number(path)
    end

    def perform
      migration_template 'add_column_template.erb', "db/migrate/add_amount_to_#{table_name.underscore.pluralize}.rb"
    end
  end
end
