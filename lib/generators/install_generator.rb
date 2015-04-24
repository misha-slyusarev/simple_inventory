module SimpleInventoryManagement
  class InstallGenerator < Rails::Generators::Base
    def install
      generate 'migration', 'InstallSimpleInventoryManagement model:string instance_id:integer amount:integer'
      rake 'db:migrate'
    end
  end
end
