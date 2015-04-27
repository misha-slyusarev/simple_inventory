module SimpleInventory
  class InstallGenerator < Rails::Generators::Base
    argument :table_prefix, type: :string, default: 'SimpleInventory'

    def install
      table_prefix_camelized = table_prefix.camelize

      create_file "config/initializers/#{table_prefix_camelized}.rb" do
      end

      generate 'migration', "Create#{table_prefix_camelized}Model name:string default_amount:integer"
      generate 'migration', "Create#{table_prefix_camelized}Instance model_id:integer amount:integer"
      generate 'migration', "Create#{table_prefix_camelized}Freeze model_id:integer instance_id:integer amount:integer"
      generate 'migration', "Create#{table_prefix_camelized}Log model_id:instance instance_id:integer comment:integer"

      table_prefix_snaked = table_prefix.underscore
      rake 'db:migrate'
    end
  end
end
