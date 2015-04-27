module SimpleInventory

  class InstallGenerator < Rails::Generators::Base
    argument :table_prefix, type: 'string', default: 'SimpleInventory'
    source_root File.expand_path('../../templates', __FILE__)

    def install
      table_prefix_camelized = table_prefix.camelize

      generate 'migration', "Create#{table_prefix_camelized}Model name:string default_amount:integer"
      generate 'migration', "Create#{table_prefix_camelized}Instance model_id:integer amount:integer"
      generate 'migration', "Create#{table_prefix_camelized}Freeze model_id:integer instance_id:integer amount:integer"
      generate 'migration', "Create#{table_prefix_camelized}Log model_id:integer instance_id:integer comment:integer"

      initializer "simple_inventory.rb" do
        <<-eof
SimpleInventory.setup do |config|
  config.table_prefix = '#{table_prefix_camelized}'
end
        eof
      end

      rake 'db:migrate'
    end
  end
end
